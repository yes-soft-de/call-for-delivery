<?php

namespace App\Manager\Notification;

use App\Constant\Notification\NotificationConstant;
use App\Repository\AdminNotificationToUsersEntityRepository;

class NotificationFromAdminManager
{
    public function __construct(
        private AdminNotificationToUsersEntityRepository $adminNotificationToUsersEntityRepository
    )
    {
    }

    /**
     * Get all notifications from admin according to user type, or user id
     */
    public function getAllNotificationsFromAdmin(int $userId, string $appType): ?array
    {
        return $this->adminNotificationToUsersEntityRepository->findBy(['userId' => [0, $userId],
            'appType' => [$appType, NotificationConstant::APP_TYPE_ALL]], ['id' => 'DESC']);
    }
}
