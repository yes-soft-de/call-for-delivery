<?php

namespace App\Manager\Notification;

use App\Repository\AdminNotificationToUsersEntityRepository;

class NotificationFromAdminManager
{
    private AdminNotificationToUsersEntityRepository $adminNotificationToUsersEntityRepository;

    public function __construct(AdminNotificationToUsersEntityRepository $adminNotificationToUsersEntityRepository)
    {
        $this->adminNotificationToUsersEntityRepository = $adminNotificationToUsersEntityRepository;
    }

    public function getAllNotificationsFromAdmin(int $userId, string $appType): ?array
    {
        return $this->adminNotificationToUsersEntityRepository->getAllNotificationsFromAdmin($userId, $appType);
    }
}
