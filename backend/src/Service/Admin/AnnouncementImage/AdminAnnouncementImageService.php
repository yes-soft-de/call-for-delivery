<?php

namespace App\Service\Admin\AnnouncementImage;

use App\AutoMapping;
use App\Constant\Admin\AnnouncementImage\AnnouncementImageResultConstant;
use App\Entity\AnnouncementImageEntity;
use App\Manager\Admin\AnnouncementImage\AdminAnnouncementImageManager;
use App\Request\Admin\AnnouncementImage\AnnouncementImageCreateByAdminRequest;
use App\Response\Admin\Notification\AdminNotificationToUser\AnnouncementImageDeleteByAdminResponse;

class AdminAnnouncementImageService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminAnnouncementImageManager $adminAnnouncementImageManager
    )
    {
    }

    /**
     * Creates the image/s of the admin notification to user
     */
    public function createAnnouncementImageByAdmin(AnnouncementImageCreateByAdminRequest $request): void
    {
        $this->adminAnnouncementImageManager->createAnnouncementImageByAdmin($request);
    }

    /**
     * Deletes the image/s of a specific admin notification to user - if exist
     */
    public function deleteAnnouncementImageByAdminNotificationToUserId(int $adminNotificationToUserId): array
    {
        return $this->adminAnnouncementImageManager->deleteAnnouncementImageByAdminNotificationToUserId($adminNotificationToUserId);
    }

    /**
     * Get AdminAnnouncementImageEntity by id or null
     */
    public function getAnnouncementImageByIdForAdmin(int $id): int|AnnouncementImageEntity
    {
        $image = $this->adminAnnouncementImageManager->getAnnouncementImageByIdForAdmin($id);

        if (! $image) {
            return AnnouncementImageResultConstant::ANNOUNCEMENT_IMAGE_NOT_FOUND_CONST;
        }

        return $image;
    }

    public function deleteAnnouncementImageById(int $id): int|AnnouncementImageDeleteByAdminResponse
    {
        $deletedAnnouncementImage = $this->adminAnnouncementImageManager->deleteAnnouncementImageById($id);

        if (! $deletedAnnouncementImage) {
            return AnnouncementImageResultConstant::ANNOUNCEMENT_IMAGE_NOT_FOUND_CONST;
        }

        return $this->autoMapping->map(AnnouncementImageEntity::class, AnnouncementImageDeleteByAdminResponse::class, $deletedAnnouncementImage);
    }
}
