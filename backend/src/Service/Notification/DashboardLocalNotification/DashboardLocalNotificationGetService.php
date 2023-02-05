<?php

namespace App\Service\Notification\DashboardLocalNotification;

use App\AutoMapping;
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
            foreach ($dashboardLocalNotifications as $notification) {
                $response[] = $this->autoMapping->map('array', DashboardLocalNotificationGetResponse::class, $notification);
            }
        }

        return $response;
    }
}
