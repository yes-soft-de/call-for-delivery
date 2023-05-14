<?php

namespace App\Response\Admin\Notification;

use DateTime;

class AdminNotificationToUsersResponse
{
    /**
     * @var int|null
     */
    public $id;

    /**
     * @var string|null
     */
    public $title;

    /**
     * @var string|null
     */
    public $msg;

    /**
     * @var DateTime|null
     */
    public $createdAt;

    /**
     * @var string|null
     */
    public $appType;
}
