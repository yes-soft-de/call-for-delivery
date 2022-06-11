<?php

namespace App\Response\Notification;

use DateTime;

class NotificationTokenResponse
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
