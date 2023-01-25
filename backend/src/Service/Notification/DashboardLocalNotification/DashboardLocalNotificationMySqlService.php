<?php

namespace App\Service\Notification\DashboardLocalNotification;

use App\Entity\DashboardLocalNotificationEntity;
use App\Entity\OrderEntity;
use App\Entity\UserEntity;
use App\Manager\Notification\DashboardLocalNotification\DashboardLocalNotificationManager;
use App\Request\Notification\DashboardLocalNotification\DashboardLocalNotificationCreateRequest;

class DashboardLocalNotificationMySqlService
{
    public function __construct(
        private DashboardLocalNotificationManager $dashboardLocalNotificationManager
    )
    {
    }

    public function createDashboardLocalNotification(DashboardLocalNotificationCreateRequest $request): DashboardLocalNotificationEntity
    {
        return $this->dashboardLocalNotificationManager->createDashboardLocalNotification($request);
    }

    public function initializeAndCreateDashboardLocalNotification(string $title, array $message, UserEntity $userEntity, int $appType, OrderEntity $orderEntity = null)
    {
        $dashboardLocalNotificationCreateRequest = new DashboardLocalNotificationCreateRequest();

        $dashboardLocalNotificationCreateRequest->setTitle($title);
        $dashboardLocalNotificationCreateRequest->setMessage($message);
        $dashboardLocalNotificationCreateRequest->setUser($userEntity);
        $dashboardLocalNotificationCreateRequest->setOrderId($orderEntity);
        $dashboardLocalNotificationCreateRequest->setAppType($appType);

        $this->createDashboardLocalNotification($dashboardLocalNotificationCreateRequest);
    }
}
