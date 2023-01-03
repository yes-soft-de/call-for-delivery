<?php

namespace App\Manager\Admin\Notification\Local;

use App\AutoMapping;
use App\Entity\NotificationLocalEntity;
use App\Request\Admin\Notification\Local\LocalNotificationCreateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminNotificationLocalManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
    }

    public function createLocalNotificationForUsersByAdmin(array $requests): array
    {
        $localNotificationEntities = [];

        foreach ($requests as $request) {
            $localNotificationEntity = $this->autoMapping->map(LocalNotificationCreateByAdminRequest::class, NotificationLocalEntity::class, $request);

            $this->entityManager->persist($localNotificationEntity);
            $this->entityManager->flush();

            $localNotificationEntities[] = $localNotificationEntity;
        }

        return $localNotificationEntities;
    }
}
