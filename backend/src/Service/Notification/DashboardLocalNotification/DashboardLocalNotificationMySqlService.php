<?php

namespace App\Service\Notification\DashboardLocalNotification;

use App\Entity\AdminProfileEntity;
use App\Entity\DashboardLocalNotificationEntity;
use App\Entity\OrderEntity;
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

    public function initializeAndCreateDashboardLocalNotification(string $title, array $message, int $appType, AdminProfileEntity $adminProfileEntity = null, OrderEntity $orderEntity = null)
    {
        $dashboardLocalNotificationCreateRequest = new DashboardLocalNotificationCreateRequest();

        $dashboardLocalNotificationCreateRequest->setTitle($title);
        $dashboardLocalNotificationCreateRequest->setMessage($message);
        $dashboardLocalNotificationCreateRequest->setOrderId($orderEntity);
        $dashboardLocalNotificationCreateRequest->setAppType($appType);
        $dashboardLocalNotificationCreateRequest->setAdminProfile($adminProfileEntity);

        $this->createDashboardLocalNotification($dashboardLocalNotificationCreateRequest);
    }
}
