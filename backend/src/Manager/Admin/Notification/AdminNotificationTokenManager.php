<?php

namespace App\Manager\Admin\Notification;

use App\Repository\NotificationFirebaseTokenEntityRepository;

class AdminNotificationTokenManager
{
    private NotificationFirebaseTokenEntityRepository $notificationFirebaseTokenEntityRepository;

    public function __construct(NotificationFirebaseTokenEntityRepository $notificationFirebaseTokenEntityRepository)
    {
        $this->notificationFirebaseTokenEntityRepository = $notificationFirebaseTokenEntityRepository;
    }

}
