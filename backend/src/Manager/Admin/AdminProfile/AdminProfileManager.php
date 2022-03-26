<?php

namespace App\Manager\Admin\AdminProfile;

use App\AutoMapping;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Entity\AdminProfileEntity;
use App\Entity\ImageEntity;
use App\Entity\UserEntity;
use App\Manager\Image\ImageManager;
use App\Manager\User\UserManager;
use App\Repository\AdminProfileEntityRepository;
use App\Request\Admin\AdminProfile\AdminProfileRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminProfileManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private ImageManager $imageManager;
    private UserManager $userManager;
    private AdminProfileEntityRepository $adminProfileEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, ImageManager $imageManager, UserManager $userManager,
                                AdminProfileEntityRepository $adminProfileEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->imageManager = $imageManager;
        $this->userManager = $userManager;
        $this->adminProfileEntityRepository = $adminProfileEntityRepository;
    }

    public function createAdminProfileRegisteredAdmin(UserEntity $userEntity): ?AdminProfileEntity
    {
        $adminProfileEntity = $this->adminProfileEntityRepository->getAdminProfileByAdminUserId($userEntity);

        if (! $adminProfileEntity) {
            $adminProfileCreateRequest = new AdminProfileRequest();

            $adminProfileCreateRequest->setUser($userEntity);
            $adminProfileCreateRequest->setName(0);

            return $this->createProfile($adminProfileCreateRequest);
        }

        return $adminProfileEntity;
    }

    public function createProfile(AdminProfileRequest $request)
    {
        $adminProfileEntity = $this->autoMapping->map(AdminProfileRequest::class, AdminProfileEntity::class, $request);

        $this->entityManager->persist($adminProfileEntity);
        $this->entityManager->flush();

        return $adminProfileEntity;
    }

    public function updateAdminProfile(AdminProfileRequest $request): AdminProfileEntity
    {
        $adminProfileEntity = $this->adminProfileEntityRepository->getAdminProfileByUserId($request->getUser());

        if (! $adminProfileEntity) {
            return $this->createProfile($request);

        } else {
            if ($request->getImagePath()) {
                $adminProfileImageEntity = $this->handleAdminProfileImage($request->getImagePath(), $adminProfileEntity->getId());

                $request->setImage($adminProfileImageEntity);

            } else {
                $request->setImage($adminProfileEntity->getImage());
            }

            $request->setUser($this->userManager->getUser($request->getUser()));

            $adminProfileEntity = $this->autoMapping->mapToObject(AdminProfileRequest::class, AdminProfileEntity::class, $request, $adminProfileEntity);

            $this->entityManager->flush();

            return $adminProfileEntity;
        }
    }

    public function handleAdminProfileImage(string $imagePath, int $itemId): ImageEntity
    {
        return $this->imageManager->createImageOrUpdate($imagePath, $itemId, ImageEntityTypeConstant::ENTITY_TYPE_ADMIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE);
    }

    public function getAdminProfileByAdminUserId(int $adminUserId): ?AdminProfileEntity
    {
        return $this->adminProfileEntityRepository->getAdminProfileByUserId($adminUserId);
    }
}
