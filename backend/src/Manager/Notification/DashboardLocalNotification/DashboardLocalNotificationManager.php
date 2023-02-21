<?php

namespace App\Manager\Notification\DashboardLocalNotification;

use App\AutoMapping;
use App\Entity\DashboardLocalNotificationEntity;
use App\Repository\DashboardLocalNotificationEntityRepository;
use App\Request\Notification\DashboardLocalNotification\DashboardLocalNotificationCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class DashboardLocalNotificationManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private DashboardLocalNotificationEntityRepository $dashboardLocalNotificationEntityRepository
    )
    {
    }

    public function createDashboardLocalNotification(DashboardLocalNotificationCreateRequest $request): DashboardLocalNotificationEntity
    {
        $dashboardLocalNotification = $this->autoMapping->map(DashboardLocalNotificationCreateRequest::class, DashboardLocalNotificationEntity::class,
            $request);

        $this->entityManager->persist($dashboardLocalNotification);
        $this->entityManager->flush();

        return $dashboardLocalNotification;
    }

    public function getAllDashboardLocalNotification(): array
    {
        return $this->dashboardLocalNotificationEntityRepository->findBy([], ['id' => 'DESC']);
    }
}
