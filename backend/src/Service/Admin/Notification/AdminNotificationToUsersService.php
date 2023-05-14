<?php

namespace App\Service\Admin\Notification;

use App\AutoMapping;
use App\Entity\AdminNotificationToUsersEntity;
use App\Manager\Admin\Notification\AdminNotificationToUsersManager;
use App\Request\Admin\AdminAnnouncementImage\AdminAnnouncementImageCreateRequest;
use App\Request\Admin\Notification\AdminNotificationCreateRequest;
use App\Request\Admin\Notification\AdminNotificationUpdateRequest;
use App\Response\Admin\Notification\AdminNotificationToUsersResponse;
use App\Response\Admin\Notification\AdminNotificationsResponse;
use App\Response\Admin\Notification\AdminNotificationToUsersNotFoundResponse;
use App\Constant\Notification\NotificationConstant;
use App\Service\Admin\AdminAnnouncementImage\AdminAnnouncementImageService;
use App\Service\Admin\Notification\Local\AdminNotificationLocalService;
use App\Service\FileUpload\UploadFileHelperService;
use App\Service\Notification\NotificationFirebaseService;
use App\Constant\Notification\NotificationFirebaseConstant;

class AdminNotificationToUsersService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private NotificationFirebaseService $notificationFirebaseService,
        private AdminNotificationLocalService $adminNotificationLocalService,
        private AdminNotificationToUsersManager $adminNotificationToUsersManager,
        private AdminAnnouncementImageService $adminAnnouncementImageService,
        private UploadFileHelperService $uploadFileHelperService
    )
    {
    }

    public function createAdminNotificationToUsers(AdminNotificationCreateRequest $request): AdminNotificationToUsersResponse
    {
        $notification = $this->adminNotificationToUsersManager->createAdminNotificationToUsers($request);

        if ($notification->getId()) {
            // insert the image record - if there is an image with the create notification request
            if (($request->getImages()) && (count($request->getImages()) > 0)) {
                $this->createAdminAnnouncementImage($request->getImages(), $notification);
            }
            // create local notification for captains if notifications send to them
            if ($request->getAppType() === NotificationConstant::APP_TYPE_CAPTAIN
                || $request->getAppType() === NotificationConstant::APP_TYPE_ALL) {
                $this->createLocalNotificationForAllCaptainsByAdmin(
                    NotificationConstant::NEW_NOTIFICATION_BY_ADMIN,
                    [
                        "text" => NotificationConstant::NEW_NOTIFICATION_TEXT_BY_ADMIN
                    ]
                );
            }

            // send firebase notification to app from admin
            try {
                $this->notificationFirebaseService->notificationToAppsFromAdmin($request->getAppType(), NotificationFirebaseConstant::NOTIFICATION_FROM_ADMIN);
            } catch (\Exception $e) {
                error_log($e);
            }
        }
        
        return $this->autoMapping->map(AdminNotificationToUsersEntity::class, AdminNotificationToUsersResponse::class, $notification);
    }

    public function updateAdminNotification(AdminNotificationUpdateRequest $request): AdminNotificationToUsersResponse|AdminNotificationToUsersNotFoundResponse
    {
        $notification = $this->adminNotificationToUsersManager->updateAdminNotification($request);

        if ($notification === NotificationConstant::NOT_FOUND) {
            $item['state'] = NotificationConstant::NOT_FOUND;
        
            return $this->autoMapping->map("array", AdminNotificationToUsersNotFoundResponse::class, $item);
        }

        //  ** Updating image ** //
        // First, delete old image/s if exist
        $this->deleteAdminAnnouncementImageByAdminNotificationToUserId($notification->getId());
        // Second, create new image/s:
        // create or update notification image/s if it/they send within the request
        if (($request->getImages()) && (count($request->getImages()) > 0)) {
            $this->createAdminAnnouncementImage($request->getImages(), $notification);
        }

        return $this->autoMapping->map(AdminNotificationToUsersEntity::class, AdminNotificationToUsersResponse::class, $notification);
    }

    public function deleteAdminNotification(int $id): AdminNotificationToUsersResponse|AdminNotificationToUsersNotFoundResponse
    {
        // First, delete any related image/s if exist
        $this->deleteAdminAnnouncementImageByAdminNotificationToUserId($id);

        $notification = $this->adminNotificationToUsersManager->deleteAdminNotification($id);

        if ($notification === NotificationConstant::NOT_FOUND) {
            $item['state'] = NotificationConstant::NOT_FOUND;
        
            return $this->autoMapping->map("array", AdminNotificationToUsersNotFoundResponse::class, $item);
        }

        return $this->autoMapping->map(AdminNotificationToUsersEntity::class, AdminNotificationToUsersResponse::class, $notification);
    }

    public function getAllNotificationsForAdmin(): array
    {
        $response = [];

        $notifications = $this->adminNotificationToUsersManager->getAllNotificationsForAdmin();
     
        foreach($notifications as $key => $value) {
            $response[$key] = $this->autoMapping->map(AdminNotificationToUsersEntity::class, AdminNotificationsResponse::class,
                $value);

            $images = $value->getAdminAnnouncementImageEntities()->toArray();

            if (count($images) > 0) {
                foreach ($images as $adminAnnouncementImageEntity) {
                    $response[$key]->images[] = $this->uploadFileHelperService->getImageParams($adminAnnouncementImageEntity->getImagePath());
                }
            }
        }

        return $response;
    }

    public function getNotificationByIdForAdmin(int $id): ?AdminNotificationsResponse
    {
        $notification = $this->adminNotificationToUsersManager->getNotificationByIdForAdmin($id);
     
        $response = $this->autoMapping->map(AdminNotificationToUsersEntity::class, AdminNotificationsResponse::class, $notification);

        $images = $notification->getAdminAnnouncementImageEntities()->toArray();

        if (count($images) > 0) {
            foreach ($images as $adminAnnouncementImageEntity) {
                $response->images[] = $this->uploadFileHelperService->getImageParams($adminAnnouncementImageEntity->getImagePath());
            }
        }

        return $response;
    }

    public function createLocalNotificationForAllCaptainsByAdmin(string $title, array $message): array|string
    {
        return $this->adminNotificationLocalService->initializeAndCreateLocalNotificationForAllCaptainsByAdmin($title, $message);
    }

    /**
     * Creates and return a new object of AdminAnnouncementImageCreateRequest
     */
    public function initializeAndReturnAdminAnnouncementImageCreateRequest(): AdminAnnouncementImageCreateRequest
    {
        return new AdminAnnouncementImageCreateRequest();
    }

    /**
     * Creates the image/s of the admin notification to user
     */
    public function createAdminAnnouncementImage(array $imagesArray, AdminNotificationToUsersEntity $adminNotificationToUsersEntity): void
    {
        $adminAnnouncementImageCreateRequest = $this->initializeAndReturnAdminAnnouncementImageCreateRequest();

        $adminAnnouncementImageCreateRequest->setAdminNotificationToUser($adminNotificationToUsersEntity);

        foreach ($imagesArray as $image) {
            $adminAnnouncementImageCreateRequest->setImagePath($image);

            $this->adminAnnouncementImageService->createAdminAnnouncementImage($adminAnnouncementImageCreateRequest);
        }
    }

    /**
     * Deletes the image/s of a specific admin notification to user - if exist
     */
    public function deleteAdminAnnouncementImageByAdminNotificationToUserId(int $adminNotificationToUserId): array
    {
        return $this->adminAnnouncementImageService->deleteAdminAnnouncementImageByAdminNotificationToUserId($adminNotificationToUserId);
    }
}
