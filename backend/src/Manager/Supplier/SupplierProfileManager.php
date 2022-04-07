<?php

namespace App\Manager\Supplier;

use App\AutoMapping;
use App\Constant\ChatRoom\ChatRoomConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\SupplierProfileEntity;
use App\Entity\UserEntity;
use App\Manager\User\UserManager;
use App\Repository\SupplierProfileEntityRepository;
use App\Request\Supplier\SupplierProfileCreateRequest;
use App\Request\User\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;

class SupplierProfileManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private UserManager $userManager;
    private SupplierProfileEntityRepository $supplierProfileEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserManager $userManager, SupplierProfileEntityRepository $supplierProfileEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->userManager = $userManager;
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
            $this->createSupplierProfile($request, $user);

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
}
