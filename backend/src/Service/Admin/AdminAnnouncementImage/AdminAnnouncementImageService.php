<?php

namespace App\Service\Admin\AdminAnnouncementImage;

use App\AutoMapping;
use App\Constant\Admin\AnnouncementImage\AdminAnnouncementImageResultConstant;
use App\Entity\AdminAnnouncementImageEntity;
use App\Manager\Admin\AdminAnnouncementImage\AdminAnnouncementImageManager;
use App\Request\Admin\AdminAnnouncementImage\AdminAnnouncementImageCreateRequest;
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

    /**
     * Get AdminAnnouncementImageEntity by id or null
     */
    public function getAnnouncementImageByIdForAdmin(int $id): int|AdminAnnouncementImageEntity
    {
        $image = $this->adminAnnouncementImageManager->getAnnouncementImageByIdForAdmin($id);

        if (! $image) {
            return AdminAnnouncementImageResultConstant::ANNOUNCEMENT_IMAGE_NOT_FOUND_CONST;
        }

        return $image;
    }

    public function deleteAnnouncementImageById(int $id): int|AnnouncementImageDeleteByAdminResponse
    {
        $deletedAnnouncementImage = $this->adminAnnouncementImageManager->deleteAnnouncementImageById($id);

        if (! $deletedAnnouncementImage) {
            return AdminAnnouncementImageResultConstant::ANNOUNCEMENT_IMAGE_NOT_FOUND_CONST;
        }

        return $this->autoMapping->map(AdminAnnouncementImageEntity::class, AnnouncementImageDeleteByAdminResponse::class, $deletedAnnouncementImage);
    }
}
