<?php

namespace App\Response\Notification;

use DateTime;

class NotificationFirebaseTokenDeleteResponse
{
    /**
     * @var int
     */
    public $id;

    /**
     * @var string
     */
    public $token;

    /**
     * @var DateTime
     */
    public $createdAt;
}
