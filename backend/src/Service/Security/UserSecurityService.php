<?php

namespace App\Service\Security;

use App\AutoMapping;
use App\Constant\Notification\NotificationTokenConstant;
use App\Response\Notification\NotificationFirebaseTokenDeleteResponse;
use App\Response\Security\UserLogoutResponse;
use App\Service\Notification\NotificationFirebaseService;

class UserSecurityService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private NotificationFirebaseService $notificationFirebaseService
    )
    {
    }

    /**
     * Deletes firebase notification token of the user
     */
    public function deleteTokenByUserId(int $userId): string|NotificationFirebaseTokenDeleteResponse
    {
        return $this->notificationFirebaseService->deleteTokenByUserId($userId);
    }

    /**
     * This suppose to do several procedures when user requires to logout:
     * Deletes firebase notification token of the user
     */
    public function logout(int $userId): string|UserLogoutResponse
    {
        // 1 delete firebase notification token
        $deleteTokenResult = $this->deleteTokenByUserId($userId);

        if ($deleteTokenResult === NotificationTokenConstant::TOKEN_NOT_FOUND) {
            return NotificationTokenConstant::TOKEN_NOT_FOUND;
        }

        return $this->autoMapping->map(NotificationFirebaseTokenDeleteResponse::class, UserLogoutResponse::class,
            $deleteTokenResult);
    }
}
