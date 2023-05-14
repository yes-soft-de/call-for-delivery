<?php

namespace App\Service\Admin\AdminAnnouncementImage;

use App\Manager\Admin\AdminAnnouncementImage\AdminAnnouncementImageManager;
use App\Request\Admin\AdminAnnouncementImage\AdminAnnouncementImageCreateRequest;

class AdminAnnouncementImageService
{
    public function __construct(
        private AdminAnnouncementImageManager $adminAnnouncementImageManager
    )
    {
    }

    /**
     * Creates the image/s of the admin notification to user
     */
    public function createAdminAnnouncementImage(AdminAnnouncementImageCreateRequest $request): void
    {
        $this->adminAnnouncementImageManager->createAdminAnnouncementImage($request);
    }

    /**
     * Deletes the image/s of a specific admin notification to user - if exist
     */
    public function deleteAdminAnnouncementImageByAdminNotificationToUserId(int $adminNotificationToUserId): array
    {
        return $this->adminAnnouncementImageManager->deleteAdminAnnouncementImageByAdminNotificationToUserId($adminNotificationToUserId);
    }
}
