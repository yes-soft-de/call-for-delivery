<?php

namespace App\Service\Admin\Notification;

use App\AutoMapping;
use App\Constant\Admin\AnnouncementImage\AnnouncementImageResultConstant;
use App\Constant\Announcement\AnnouncementResultConstant;
use App\Entity\AnnouncementImageEntity;
use App\Entity\AdminNotificationToUsersEntity;
use App\Manager\Admin\Notification\AdminNotificationToUsersManager;
use App\Request\Admin\AnnouncementImage\AnnouncementImageCreateByAdminRequest;
use App\Request\Admin\Notification\AdminNotificationCreateRequest;
use App\Request\Admin\Notification\AdminNotificationUpdateRequest;
use App\Response\Admin\Notification\AdminNotificationToUser\AdminNotificationToUserUpdateResponse;
use App\Response\Admin\Notification\AdminNotificationToUsersResponse;
use App\Response\Admin\Notification\AdminNotificationsResponse;
use App\Response\Admin\Notification\AdminNotificationToUsersNotFoundResponse;
use App\Constant\Notification\NotificationConstant;
use App\Service\Admin\AnnouncementImage\AdminAnnouncementImageService;
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
        private UploadFileHelperService $uploadFileHelperService,
    )
    {
    }

    public function createAdminNotificationToUsers(AdminNotificationCreateRequest $request): AdminNotificationToUsersResponse
    {
        $notification = $this->adminNotificationToUsersManager->createAdminNotificationToUsers($request);

        if ($notification->getId()) {
            // insert the image record - if there is an image with the create notification request
            if (($request->getImages()) && (count($request->getImages()) > 0)) {
                $this->createAnnouncementImagesByAdmin($request->getImages(), $notification);
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

    public function updateAdminNotification(AdminNotificationUpdateRequest $request): AdminNotificationToUserUpdateResponse|AdminNotificationToUsersNotFoundResponse
    {
        $notification = $this->adminNotificationToUsersManager->updateAdminNotification($request);

        if ($notification === NotificationConstant::NOT_FOUND) {
            $item['state'] = NotificationConstant::NOT_FOUND;

            return $this->autoMapping->map("array", AdminNotificationToUsersNotFoundResponse::class, $item);
        }

        //  ** Updating image/s ** //
        // create or update notification image/s if it/they send within the request
        if (($request->getImages()) && (count($request->getImages()) > 0)) {
            $this->createImagesIfNotExist($request->getImages(), $notification);
        }

        $response = $this->autoMapping->map(AdminNotificationToUsersEntity::class, AdminNotificationToUserUpdateResponse::class,
            $notification);

        $images = $notification->getAnnouncementImageEntities()->toArray();

        if (count($images) > 0) {
            foreach ($images as $key => $value) {
                $response->images[$key]['id'] = $value->getId();
                $response->images[$key]['image'] = $this->uploadFileHelperService->getImageParams($value->getImagePath());
            }
        }

        return $response;
    }

    public function deleteAdminNotification(int $id): AdminNotificationToUsersResponse|AdminNotificationToUsersNotFoundResponse
    {
        // First, delete any related image/s if exist
        $this->deleteAnnouncementImageByAdminNotificationToUserId($id);

        // Now delete the notification
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

        foreach ($notifications as $key => $value) {
            $response[$key] = $this->autoMapping->map(AdminNotificationToUsersEntity::class, AdminNotificationsResponse::class,
                $value);

            $images = $value->getAnnouncementImageEntities()->toArray();

            if (count($images) > 0) {
                foreach ($images as $key2 => $value2) {
                    $response[$key]->images[$key2]['id'] = $value2->getId();
                    $response[$key]->images[$key2]['image'] = $this->uploadFileHelperService->getImageParams($value2->getImagePath());
                }
            }
        }

        return $response;
    }

    public function getNotificationByIdForAdmin(int $id): string|AdminNotificationsResponse
    {
        $notification = $this->adminNotificationToUsersManager->getNotificationByIdForAdmin($id);

        if (! $notification) {
            return AnnouncementResultConstant::ANNOUNCEMENT_NOT_EXIST;
        }

        $response = $this->autoMapping->map(AdminNotificationToUsersEntity::class, AdminNotificationsResponse::class, $notification);

        $images = $notification->getAnnouncementImageEntities()->toArray();

        if (count($images) > 0) {
            foreach ($images as $key => $value) {
                $response->images[$key]['id'] = $value->getId();
                $response->images[$key]['image'] = $this->uploadFileHelperService->getImageParams($value->getImagePath());
            }
        }

        return $response;
    }

    public function createLocalNotificationForAllCaptainsByAdmin(string $title, array $message): array|string
    {
        return $this->adminNotificationLocalService->initializeAndCreateLocalNotificationForAllCaptainsByAdmin($title, $message);
    }

    /**
     * Creates and return a new object of AnnouncementImageCreateByAdminRequest
     */
    public function initializeAndReturnAnnouncementImageCreateByAdminRequest(): AnnouncementImageCreateByAdminRequest
    {
        return new AnnouncementImageCreateByAdminRequest();
    }

    /**
     * Creates the image/s of the admin notification to user
     */
    public function createAnnouncementImagesByAdmin(array $imagesArray, AdminNotificationToUsersEntity $adminNotificationToUsersEntity): void
    {
        $adminAnnouncementImageCreateRequest = $this->initializeAndReturnAnnouncementImageCreateByAdminRequest();

        $adminAnnouncementImageCreateRequest->setAdminNotificationToUser($adminNotificationToUsersEntity);

        foreach ($imagesArray as $image) {
            $adminAnnouncementImageCreateRequest->setImagePath($image);

            $this->adminAnnouncementImageService->createAnnouncementImageByAdmin($adminAnnouncementImageCreateRequest);
        }
    }

    /**
     * Deletes the image/s of a specific admin notification to user - if exist
     */
    public function deleteAnnouncementImageByAdminNotificationToUserId(int $adminNotificationToUserId): array
    {
        return $this->adminAnnouncementImageService->deleteAnnouncementImageByAdminNotificationToUserId($adminNotificationToUserId);
    }

    /**
     * Creates the image of the admin notification to user
     */
    public function createAnnouncementImageByAdmin(string $imagePath, AdminNotificationToUsersEntity $adminNotificationToUsersEntity): void
    {
        $adminAnnouncementImageCreateRequest = $this->initializeAndReturnAnnouncementImageCreateByAdminRequest();

        $adminAnnouncementImageCreateRequest->setAdminNotificationToUser($adminNotificationToUsersEntity);
        $adminAnnouncementImageCreateRequest->setImagePath($imagePath);

        $this->adminAnnouncementImageService->createAnnouncementImageByAdmin($adminAnnouncementImageCreateRequest);
    }

    /**
     * Get AdminAnnouncementImageEntity by id or constant
     */
    public function getAnnouncementImageByIdForAdmin(int $id): int|AnnouncementImageEntity
    {
        return $this->adminAnnouncementImageService->getAnnouncementImageByIdForAdmin($id);
    }

    /**
     * Creates image/s if not exists
     */
    public function createImagesIfNotExist(array $images, AdminNotificationToUsersEntity $adminNotificationToUsersEntity)
    {
        foreach ($images as $image) {
            if ($this->getAnnouncementImageByIdForAdmin($image['id']) === AnnouncementImageResultConstant::ANNOUNCEMENT_IMAGE_NOT_FOUND_CONST) {
                // create the image as long as it doesn't exist
                $this->createAnnouncementImageByAdmin($image['image'], $adminNotificationToUsersEntity);
            }
        }
    }
}
