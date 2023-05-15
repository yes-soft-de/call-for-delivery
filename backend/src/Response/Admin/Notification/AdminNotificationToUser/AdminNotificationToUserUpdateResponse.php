<?php

namespace App\Response\Admin\Notification\AdminNotificationToUser;

use DateTime;
use OpenApi\Annotations as OA;

class AdminNotificationToUserUpdateResponse
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
     * @var DateTime|null
     */
    public $updatedAt;

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
