<?php

namespace App\Manager\Notification;

use App\AutoMapping;
use App\Repository\AdminNotificationToUsersEntityRepository;
use Doctrine\ORM\EntityManagerInterface;

class NotificationFromAdminManager
{
    private AdminNotificationToUsersEntityRepository $adminNotificationToUsersEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, AdminNotificationToUsersEntityRepository $adminNotificationToUsersEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->adminNotificationToUsersEntityRepository = $adminNotificationToUsersEntityRepository;
    }

    public function getAllNotificationsFromAdminForStore($userId, $appType): ?array
    {
        return $this->adminNotificationToUsersEntityRepository->getAllNotificationsFromAdminForStore($userId, $appType);
    }
}
