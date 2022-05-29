<?php

namespace App\Manager\UserStatus;

use App\AutoMapping;
use App\Constant\UserStatus\UserStatusConstant;
use App\Entity\UserEntity;
use App\Repository\UserEntityRepository;
use App\Request\UserStatus\UserStatusUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class UserStatusManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private UserEntityRepository $userEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserEntityRepository $userEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->userEntityRepository = $userEntityRepository;
    }

    public function updateUserStatus(UserStatusUpdateRequest $request): UserEntity|string|null
    {
        if ($request->getStatus() === UserStatusConstant::USER_STATUS_MAINTENANCE_MOOD) {
            $userEntity = $this->userEntityRepository->find($request->getId());

            if ($userEntity) {
                $userEntity->setStatus($request->getStatus());

                $this->entityManager->flush();
            }

            return $userEntity;
        }

        return UserStatusConstant::WRONG_USER_STATUS;
    }

    public function activateAllUsersBySuperAdmin(): array
    {
        $usersEntities = $this->userEntityRepository->findAll();

        if ($usersEntities) {
            foreach ($usersEntities as $userEntity) {
                $userEntity->setStatus(UserStatusConstant::USER_STATUS_ACTIVATED);

                $this->entityManager->flush();
            }
        }

        return $usersEntities;
    }
}
