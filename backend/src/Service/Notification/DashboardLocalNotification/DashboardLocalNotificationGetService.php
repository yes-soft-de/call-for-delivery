<?php

namespace App\Service\Notification\DashboardLocalNotification;

use App\AutoMapping;
use App\Entity\DashboardLocalNotificationEntity;
use App\Manager\Notification\DashboardLocalNotification\DashboardLocalNotificationManager;
use App\Response\Notification\DashboardLocalNotification\DashboardLocalNotificationGetResponse;

class DashboardLocalNotificationGetService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private DashboardLocalNotificationManager $dashboardLocalNotificationManager
    )
    {
    }

    public function getAllDashboardLocalNotification(): array
    {
        $response = [];

        $dashboardLocalNotifications = $this->dashboardLocalNotificationManager->getAllDashboardLocalNotification();

        if (count($dashboardLocalNotifications) > 0) {
            foreach ($dashboardLocalNotifications as $key => $value) {
                $response[$key] = $this->autoMapping->map(DashboardLocalNotificationEntity::class, DashboardLocalNotificationGetResponse::class,
                    $value);

                if ($value->getOrderId()) {
                    $response[$key]->orderId = $value->getOrderId()->getId();
                }

                if ($value->getAdminProfile()) {
                    $response[$key]->adminName = $value->getAdminProfile()->getName();
                }
            }
        }

        return $response;
    }
}
