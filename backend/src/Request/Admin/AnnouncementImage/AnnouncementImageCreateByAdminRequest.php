<?php

namespace App\Request\Admin\AnnouncementImage;

use App\Entity\AdminNotificationToUsersEntity;

class AnnouncementImageCreateByAdminRequest
{
    private string $imagePath;

    /**
     * @var AdminNotificationToUsersEntity
     */
    private $AdminNotificationToUser;

    public function setImagePath(string $imagePath): void
    {
        $this->imagePath = $imagePath;
    }

    public function setAdminNotificationToUser(AdminNotificationToUsersEntity $AdminNotificationToUser): void
    {
        $this->AdminNotificationToUser = $AdminNotificationToUser;
    }
}
