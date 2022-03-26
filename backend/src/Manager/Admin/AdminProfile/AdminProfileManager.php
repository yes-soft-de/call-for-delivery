<?php

namespace App\Manager\Admin\AdminProfile;

use App\AutoMapping;
use App\Entity\AdminProfileEntity;
use App\Manager\User\UserManager;
use App\Repository\AdminProfileEntityRepository;
use App\Request\Admin\AdminProfileCreateRequest;
use App\Request\Admin\AdminProfileUpdateRequest;
use App\Request\Admin\AdminRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminProfileManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private UserManager $userManager;
    private AdminProfileEntityRepository $adminProfileEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserManager $userManager, AdminProfileEntityRepository $adminProfileEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->userManager = $userManager;
        $this->adminProfileEntityRepository = $adminProfileEntityRepository;
    }

    public function createAdminProfileRegisteredAdmin(AdminRegisterRequest $request, int $registeredAdminUserId): ?AdminProfileEntity
    {
        $adminProfileEntity = $this->adminProfileEntityRepository->getAdminProfileByAdminUserId($request->getUserID());

        if (! $adminProfileEntity) {
            $adminProfileCreateRequest = new AdminProfileCreateRequest();

            $adminProfileCreateRequest->setAdminUserId($registeredAdminUserId);
            $adminProfileCreateRequest->setName(0);

            return $this->createProfile($adminProfileCreateRequest);
        }

        return $adminProfileEntity;
    }

    public function createProfile(AdminProfileCreateRequest $request)
    {
        $adminProfileEntity = $this->autoMapping->map(AdminProfileCreateRequest::class, AdminProfileEntity::class, $request);

        $this->entityManager->persist($adminProfileEntity);
        $this->entityManager->flush();

        return $adminProfileEntity;
    }

    public function getAdminProfileWithImageByAdminUserId(int $adminUserId): ?array
    {
        return $this->adminProfileEntityRepository->getAdminProfileWithImageByAdminUserId($adminUserId);
    }

    public function updateAdminProfile(AdminProfileUpdateRequest $request): AdminProfileEntity
    {
        $adminProfileEntity = $this->adminProfileEntityRepository->find($request->getAdminUserId());

        if (! $adminProfileEntity) {
            $adminProfileEntity = $this->autoMapping->map(AdminProfileUpdateRequest::class, AdminProfileCreateRequest::class, $request);

            return $this->createProfile($adminProfileEntity);

        } else {
            $adminProfileEntity = $this->autoMapping->mapToObject(AdminProfileUpdateRequest::class, AdminProfileEntity::class, $request, $adminProfileEntity);

            $this->entityManager->flush();

            return $adminProfileEntity;
        }
    }
}
