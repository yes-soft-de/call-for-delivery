<?php

namespace App\Service\UserStatus;

use App\AutoMapping;
use App\Constant\UserStatus\UserStatusConstant;
use App\Entity\UserEntity;
use App\Manager\UserStatus\UserStatusManager;
use App\Request\UserStatus\UserStatusUpdateRequest;
use App\Response\UserStatus\UserStatusUpdateResponse;

class UserStatusService
{
    private AutoMapping $autoMapping;
    private UserStatusManager $userStatusManager;

    public function __construct(AutoMapping $autoMapping, UserStatusManager $userStatusManager)
    {
        $this->autoMapping = $autoMapping;
        $this->userStatusManager = $userStatusManager;
    }

    public function updateUserStatus(UserStatusUpdateRequest $request): string|UserStatusUpdateResponse|null
    {
        $userResult = $this->userStatusManager->updateUserStatus($request);

        if ($userResult === UserStatusConstant::WRONG_USER_STATUS) {
            return UserStatusConstant::WRONG_USER_STATUS;
        }

        return $this->autoMapping->map(UserEntity::class, UserStatusUpdateResponse::class, $userResult);
    }

    public function activateAllUsersBySuperAdmin(): array
    {
        $response = [];

        $usersResults = $this->userStatusManager->activateAllUsersBySuperAdmin();

        if ($usersResults) {
            foreach ($usersResults as $userEntity) {
                $response[] = $this->autoMapping->map(UserEntity::class, UserStatusUpdateResponse::class, $userEntity);
            }
        }

        return $response;
    }
}
