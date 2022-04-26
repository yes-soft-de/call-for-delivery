<?php

namespace App\Manager\Admin\User;

use App\Constant\Admin\User\AdminUserConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\UserEntity;
use App\Repository\UserEntityRepository;
use App\Request\Admin\User\UserIdUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminUserManager
{
    private EntityManagerInterface $entityManager;
    private UserEntityRepository $userEntityRepository;

    public function __construct(EntityManagerInterface $entityManager, UserEntityRepository $userEntityRepository)
    {
        $this->userEntityRepository = $userEntityRepository;
        $this->entityManager = $entityManager;
    }

    public function updateUserIdBySuperAdmin(UserIdUpdateRequest $request): UserEntity|string
    {
        if ($request->getPassword() !== AdminUserConstant::USERID_UPDATE_PASSWORD_CONST) {
            return AdminUserConstant::WRONG_PASSWORD;

        }

        $userEntity = $this->userEntityRepository->findOneBy(["userId"=>$request->getCurrentUserId()]);

        if (! $userEntity) {
            return UserReturnResultConstant::USER_IS_NOT_CREATED_RESULT;
        }

        $userEntity->setUserId($request->getNewUserId());

        $this->entityManager->flush();

        return $userEntity;
    }
}
