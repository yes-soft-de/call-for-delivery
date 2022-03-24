<?php

namespace App\Manager\Admin;

use App\AutoMapping;
use App\Constant\Admin\AdminProfileStatusConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\AdminProfileEntity;
use App\Entity\UserEntity;
use App\Repository\AdminProfileEntityRepository;
use App\Request\Admin\AdminProfileCreateRequest;
use App\Request\Admin\AdminProfileUpdateRequest;
use App\Request\Admin\AdminRegisterRequest;
use App\Manager\User\UserManager;
use Doctrine\ORM\EntityManagerInterface;

class AdminManager
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

    public function getUserByUserId($userID): ?array
    {
        return $this->userManager->getUserByUserId($userID);
    }

    public function adminRegister(AdminRegisterRequest $request): UserEntity|string
    {
        $user = $this->userManager->getUserByUserId($request->getUserId());

        if (! $user) {
            if(! $request->getRoles()) {
                $request->setRoles(["ROLE_ADMIN"]);
            }

            $userRegister = $this->userManager->createAdmin($request);

            if($userRegister){
                $this->createAdminProfileRegisteredAdmin($request, $userRegister->getId());

                return $userRegister;
            }
            else{
                return UserReturnResultConstant::USER_IS_NOT_CREATED_RESULT;
            }
        }
        else {
            $this->createAdminProfileRegisteredAdmin($request, $user['id']);

            return UserReturnResultConstant::USER_IS_FOUND_RESULT;
        }
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
