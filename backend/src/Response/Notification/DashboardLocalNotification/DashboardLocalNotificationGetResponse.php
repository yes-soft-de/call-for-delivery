<?php

namespace App\Response\Notification\DashboardLocalNotification;

use OpenApi\Annotations as OA;

class DashboardLocalNotificationGetResponse
{
    public string $id;

    public string $title;

    /**
     * @OA\Property(type="array", property="message",
     *     @OA\Items(type="object"))
     */
    public $message;

    public string $adminName;

    /**
     * @var int|null
     */
    public $orderId;

    public \DateTime $createdAt;
}
