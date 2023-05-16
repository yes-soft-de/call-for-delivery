<?php

namespace App\Response\Admin\Notification\AdminNotificationToUser;

use DateTime;

class AnnouncementImageDeleteByAdminResponse
{
    public string $imagePath;

    /**
     * @var DateTime|null
     */
    public $createdAt;

    /**
     * @var DateTime|null
     */
    public $updatedAt;
}
