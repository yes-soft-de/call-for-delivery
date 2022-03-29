<?php

namespace App\Service\Notification;

use App\AutoMapping;
use App\Manager\Notification\NotificationFromAdminManager;
use App\Response\Notification\NotificationFromAdminResponse;

class NotificationFromAdminService
{
    private $autoMapping;
    private $notificationFromAdminManager;

    public function __construct(AutoMapping $autoMapping, NotificationFromAdminManager $notificationFromAdminManager)
    {
        $this->autoMapping = $autoMapping;
        $this->notificationFromAdminManager = $notificationFromAdminManager;
    }

    public function getAllNotificationsFromAdmin($userId, $appType): ?array
    {
        $response = [];

        $notifications = $this->notificationFromAdminManager->getAllNotificationsFromAdmin($userId, $appType);
     
        foreach($notifications as $notification) {

            $response[] = $this->autoMapping->map("array", NotificationFromAdminResponse::class, $notification);
        }

        return $response;
    }
}
