<?php

namespace App\Manager\Admin\AdminProfile;

use App\AutoMapping;
use App\Constant\Admin\AdminProfileConstant;
use App\Entity\AdminProfileEntity;
use App\Entity\UserEntity;
use App\Manager\Image\ImageManager;
use App\Manager\User\UserManager;
use App\Repository\AdminProfileEntityRepository;
use App\Request\Admin\AdminProfile\AdminProfileRequest;
use App\Request\Admin\AdminProfile\AdminProfileStatusUpdateRequest;
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

    public function createProfile(AdminProfileRequest $request): AdminProfileEntity
    {
        $adminProfileEntity = $this->autoMapping->map(AdminProfileRequest::class, AdminProfileEntity::class, $request);

        $this->entityManager->persist($adminProfileEntity);
        $this->entityManager->flush();

        return $adminProfileEntity;
    }

    public function updateAdminProfile(AdminProfileRequest $request): string|AdminProfileEntity
    {
        $adminProfileEntity = $this->adminProfileEntityRepository->find($request->getId());

        if (! $adminProfileEntity) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;

        } else {
            if (! empty($request->getImages())) {
                $images = $this->handleAdminProfileImages($request->getImages(), $adminProfileEntity);

                $request->setImages($images);
            }

            $adminProfileEntity = $this->autoMapping->mapToObject(AdminProfileRequest::class, AdminProfileEntity::class, $request, $adminProfileEntity);

            $this->entityManager->flush();

            return $adminProfileEntity;
        }
    }

    public function handleAdminProfileImages(array $images, AdminProfileEntity $adminProfileEntity): array
    {
        return $this->imageManager->createOrUpdateAdminProfileImages($images, $adminProfileEntity);
    }

    public function getAdminProfileByAdminUserId(int $adminUserId): ?AdminProfileEntity
    {
        return $this->adminProfileEntityRepository->getAdminProfileByUserId($adminUserId);
    }

    public function updateAdminProfileStatus(AdminProfileStatusUpdateRequest $request): string|AdminProfileEntity
    {
        $adminProfileEntity = $this->adminProfileEntityRepository->find($request->getId());

        if (! $adminProfileEntity) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;

        } else {
            $adminProfileEntity = $this->autoMapping->mapToObject(AdminProfileStatusUpdateRequest::class, AdminProfileEntity::class, $request, $adminProfileEntity);

            $this->entityManager->flush();

            return $adminProfileEntity;
        }
    }

    public function updateAdminProfileBySuperAdmin(AdminProfileRequest $request): string|AdminProfileEntity
    {
        $adminProfileEntity = $this->adminProfileEntityRepository->find($request->getId());

        if (! $adminProfileEntity) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;

        } else {
            $request->setUser($adminProfileEntity->getUser());

            if (! empty($request->getImages())) {
                $images = $this->handleAdminProfileImages($request->getImages(), $adminProfileEntity);

                $request->setImages($images);
            }

            $adminProfileEntity = $this->autoMapping->mapToObject(AdminProfileRequest::class, AdminProfileEntity::class, $request, $adminProfileEntity);

            $this->entityManager->flush();

            return $adminProfileEntity;
        }
    }
}
