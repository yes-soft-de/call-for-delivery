<?php

namespace App\Response\Admin\Notification;

use DateTime;
use OpenApi\Annotations as OA;

class AdminNotificationsResponse
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

    /**
     * @OA\Property(type="array", property="images",
     *     @OA\Items(type="object"))
     */
    public $images;
}
