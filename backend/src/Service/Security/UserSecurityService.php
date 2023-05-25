<?php

namespace App\Service\Security;

use App\Response\Notification\NotificationFirebaseTokenDeleteResponse;
use App\Service\Notification\NotificationFirebaseService;

class UserSecurityService
{
    public function __construct(
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
     *
     */
    public function logout(int $userId)
    {
        // 1 delete firebase notification token
        $this->deleteTokenByUserId($userId);
    }
}
