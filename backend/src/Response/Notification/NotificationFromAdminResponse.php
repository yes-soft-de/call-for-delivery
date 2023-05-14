<?php

namespace App\Response\Notification;

use DateTime;
use OpenApi\Annotations as OA;

class NotificationFromAdminResponse
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
     * @OA\Property(type="array", property="images",
     *     @OA\Items(type="object"))
     */
    public $images;
}
