<?php

namespace App\Manager\Supplier;

use App\AutoMapping;
use App\Constant\ChatRoom\ChatRoomConstant;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Constant\User\UserRoleConstant;
use App\Entity\SupplierProfileEntity;
use App\Entity\UserEntity;
use App\Manager\Image\ImageManager;
use App\Manager\SupplierCategory\SupplierCategoryManager;
use App\Manager\User\UserManager;
use App\Repository\SupplierProfileEntityRepository;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Request\Supplier\SupplierProfileCreateRequest;
use App\Request\Supplier\SupplierProfileUpdateRequest;
use App\Request\User\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;

class SupplierProfileManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private UserManager $userManager;
    private ImageManager $imageManager;
    private SupplierCategoryManager $supplierCategoryManager;
    private SupplierProfileEntityRepository $supplierProfileEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserManager $userManager, ImageManager $imageManager, SupplierCategoryManager $supplierCategoryManager,
                                SupplierProfileEntityRepository $supplierProfileEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->userManager = $userManager;
        $this->imageManager = $imageManager;
        $this->supplierCategoryManager = $supplierCategoryManager;
        $this->supplierProfileEntityRepository = $supplierProfileEntityRepository;
    }

    public function registerSupplier(UserRegisterRequest $request): string|UserEntity
    {
        $user = $this->userManager->getUserEntityByUserId($request->getUserId());

        if (! $user) {
            $request->setRoles(["ROLE_SUPPLIER", "ROLE_USER"]);

            $userRegister = $this->userManager->createUser($request, ChatRoomConstant::ADMIN_SUPPLIER);

            if ($userRegister) {
                $this->createSupplierProfile($request, $userRegister);

                return $userRegister;

            } else {
                return UserReturnResultConstant::USER_IS_NOT_CREATED_RESULT;
            }

        } else {
            if (in_array(UserRoleConstant::ROLE_SUPPLIER, $user->getRoles())) {
                $supplierProfile = $this->getSupplierProfileEntityBySupplierId($user->getId());

                if (! $supplierProfile) {
                    $this->createSupplierProfile($request, $user);
                }
            }

            return UserReturnResultConstant::USER_IS_FOUND_RESULT;
        }
    }

    public function createSupplierProfile(UserRegisterRequest $request, UserEntity $userEntity): string|SupplierProfileEntity
    {
        $supplierProfile = $this->supplierProfileEntityRepository->findOneBy(["user"=>$userEntity]);

        if (! $supplierProfile) {
            $supplierProfileRequest = new SupplierProfileCreateRequest();

            $supplierProfileRequest->setUser($userEntity);
            $supplierProfileRequest->setSupplierName("0");

            return $this->createProfile($supplierProfileRequest);
        }

        return UserReturnResultConstant::USER_IS_FOUND_RESULT;
    }

    public function createProfile(SupplierProfileCreateRequest $request): SupplierProfileEntity
    {
        $supplierProfileEntity = $this->autoMapping->map(SupplierProfileCreateRequest::class, SupplierProfileEntity::class, $request);

        $this->entityManager->persist($supplierProfileEntity);
        $this->entityManager->flush();

        return $supplierProfileEntity;
    }

    public function updateSupplierProfile(SupplierProfileUpdateRequest $request): string|SupplierProfileEntity
    {
        $supplierProfileEntity = $this->supplierProfileEntityRepository->findOneBy(["user"=>$request->getUser()]);

        if (! $supplierProfileEntity) {
            return SupplierProfileConstant::SUPPLIER_PROFILE_NOT_EXIST;

        } else {
            $request->setUser($supplierProfileEntity->getUser());

            //$request->setSupplierCategory($this->supplierCategoryManager->getSupplierCategoryEntityByCategoryId($request->getSupplierCategory()));

            if ($request->getAllSupplierCategories()) {
                $request->setSupplierCategories($this->supplierCategoryManager->getAllActiveSupplierCategoriesIDs());
            }

            if (! empty($request->getImages())) {
                $request->setImages($this->createOrUpdateSupplierProfileImage($request->getImages(), $supplierProfileEntity));
            }

            $supplierProfileEntity = $this->autoMapping->mapToObject(SupplierProfileUpdateRequest::class, SupplierProfileEntity::class,
                $request, $supplierProfileEntity);

            if ($supplierProfileEntity->getCompleteAccountStatus() === SupplierProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED) {
                $supplierProfileEntity->setCompleteAccountStatus(SupplierProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_COMPLETED);
            }

            $this->entityManager->flush();

            return $supplierProfileEntity;
        }
    }

    public function getSupplierProfileByUserId(int $userId): ?array
    {
        $supplierProfile = $this->supplierProfileEntityRepository->getSupplierProfileByUserId($userId);

        if ($supplierProfile) {
            $supplierProfile['images'] = $this->imageManager->getImagesByItemIdAndEntityTypeAndImageAim($supplierProfile['id'], ImageEntityTypeConstant::ENTITY_TYPE_SUPPLIER_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE);
        }

        return $supplierProfile;
    }

    public function createOrUpdateSupplierProfileImage(array $images, SupplierProfileEntity $supplierProfileEntity): array
    {
        return $this->imageManager->createOrUpdateSupplierProfileImages($images, $supplierProfileEntity);
    }

    public function getSupplierProfileEntityBySupplierId(int $supplierId): ?SupplierProfileEntity
    {
        return $this->supplierProfileEntityRepository->findOneBy(["user"=>$supplierId]);
    }

    public function getCompleteAccountStatusBySupplierId(int $supplierId): ?array
    {
        return $this->supplierProfileEntityRepository->getCompleteAccountStatusBySupplierId($supplierId);
    }

    public function supplierProfileCompleteAccountStatusUpdate(CompleteAccountStatusUpdateRequest $request): SupplierProfileEntity|string
    {
        if (! $this->checkCompleteAccountStatusValidity($request->getCompleteAccountStatus())) {
            return SupplierProfileConstant::WRONG_COMPLETE_ACCOUNT_STATUS;
        }

        $supplierProfile = $this->supplierProfileEntityRepository->getSupplierProfileEntityByUserId($request->getUserId());

        if ($supplierProfile) {
            $supplierProfile = $this->autoMapping->mapToObject(CompleteAccountStatusUpdateRequest::class, SupplierProfileEntity::class, $request, $supplierProfile);

            $this->entityManager->flush();

            return $supplierProfile;
        }
    }

    public function checkCompleteAccountStatusValidity(string $completeAccountStatus): bool
    {
        if ($completeAccountStatus !== SupplierProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED && $completeAccountStatus !== SupplierProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_COMPLETED) {
            return false;
        }

        return true;
    }

    public function getSupplierCategoriesNamesBySupplierCategoriesIDs(array $supplierCategoriesIDs): array
    {
        return $this->supplierCategoryManager->getSupplierCategoriesNamesBySupplierCategoriesIDs($supplierCategoriesIDs);
    }
}
