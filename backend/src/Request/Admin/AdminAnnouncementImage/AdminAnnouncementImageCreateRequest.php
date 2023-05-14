<?php

namespace App\Request\Admin\AdminAnnouncementImage;

use App\Entity\AdminNotificationToUsersEntity;

class AdminAnnouncementImageCreateRequest
{
    private string $imagePath;

    /**
     * @var int|AdminNotificationToUsersEntity
     */
    private $AdminNotificationToUser;

    public function setImagePath(string $imagePath): void
    {
        $this->imagePath = $imagePath;
    }

    public function setAdminNotificationToUser(AdminNotificationToUsersEntity|int $AdminNotificationToUser): void
    {
        $this->AdminNotificationToUser = $AdminNotificationToUser;
    }
}
