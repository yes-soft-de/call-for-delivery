<?php

namespace App\Service\Notification;

use App\AutoMapping;
use App\Constant\Announcement\AnnouncementLimitConstant;
use App\Entity\AdminNotificationToUsersEntity;
use App\Manager\Notification\NotificationFromAdminManager;
use App\Response\Notification\NotificationFromAdminResponse;
use App\Service\FileUpload\UploadFileHelperService;

class NotificationFromAdminService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private NotificationFromAdminManager $notificationFromAdminManager,
        private UploadFileHelperService $uploadFileHelperService
    )
    {
    }

    /**
     * Get image url, base url, and image url + base url in an array result
     */
    public function getImageParams(string $imagePath): ?array
    {
        return $this->uploadFileHelperService->getImageParams($imagePath);
    }

    /**
     * Get notifications from admin according to user type, or user id, and limit number (if entered)
     */
    public function getAllNotificationsFromAdmin(int $userId, string $appType, int $limit= null): array
    {
        $response = [];
        $notifications = [];

        if ((! $limit) || ($limit === AnnouncementLimitConstant::ANNOUNCEMENT_GET_ALL_CONST)) {
            $notifications = $this->notificationFromAdminManager->getAllNotificationsFromAdmin($userId, $appType);

        } elseif ($limit === AnnouncementLimitConstant::ANNOUNCEMENT_GET_LAST_SEVEN_CONST) {
            $notifications = $this->notificationFromAdminManager->getLastNotificationsFromAdminByLimit($userId, $appType,
                AnnouncementLimitConstant::ANNOUNCEMENT_LIMIT_SEVEN_CONST);
        }
     
        foreach ($notifications as $key => $value) {
            $response[$key] = $this->autoMapping->map(AdminNotificationToUsersEntity::class, NotificationFromAdminResponse::class, $value);

            $images = $value->getAdminAnnouncementImageEntities()->toArray();

            if (count($images) > 0) {
                foreach ($images as $adminAnnouncementImageEntity) {
                    $response[$key]->images[] = $this->getImageParams($adminAnnouncementImageEntity->getImagePath());
                }
            }
        }

        return $response;
    }
}
