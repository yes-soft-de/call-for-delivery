<?php

namespace App\Response\Notification;

use DateTime;

class NotificationFirebaseTokenDeleteResponse
{
    public ?int $id;

    public string $token;

    public DateTime $createdAt;
}
