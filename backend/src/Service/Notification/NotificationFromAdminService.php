<?php

namespace App\Service\Notification;

use App\AutoMapping;
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
     * Get all notifications from admin according to user type, or user id
     */
    public function getAllNotificationsFromAdmin(int $userId, string $appType): array
    {
        $response = [];

        $notifications = $this->notificationFromAdminManager->getAllNotificationsFromAdmin($userId, $appType);
     
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
