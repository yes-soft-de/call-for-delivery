<?php

namespace App\Service\Admin\Notification;

use App\AutoMapping;
use App\Entity\AdminNotificationToUsersEntity;
use App\Manager\Admin\Notification\AdminNotificationToUsersManager;
use App\Request\Admin\Notification\AdminNotificationCreateRequest;
use App\Request\Admin\Notification\AdminNotificationUpdateRequest;
use App\Response\Admin\Notification\AdminNotificationToUsersResponse;
use App\Response\Admin\Notification\AdminNotificationsResponse;
use App\Response\Admin\Notification\AdminNotificationToUsersNotFoundResponse;
use App\Constant\Notification\NotificationConstant;
use App\Service\Admin\Notification\Local\AdminNotificationLocalService;
use App\Service\Notification\NotificationFirebaseService;
use App\Constant\Notification\NotificationFirebaseConstant;

class AdminNotificationToUsersService
{
    private AutoMapping $autoMapping;
    private NotificationFirebaseService $notificationFirebaseService;
    private AdminNotificationLocalService $adminNotificationLocalService;
    private AdminNotificationToUsersManager $adminNotificationToUsersManager;

    public function __construct(AutoMapping $autoMapping, NotificationFirebaseService $notificationFirebaseService, AdminNotificationLocalService $adminNotificationLocalService,
                                AdminNotificationToUsersManager $adminNotificationToUsersManager)
    {
        $this->autoMapping = $autoMapping;
        $this->notificationFirebaseService = $notificationFirebaseService;
        $this->adminNotificationLocalService = $adminNotificationLocalService;
        $this->adminNotificationToUsersManager = $adminNotificationToUsersManager;
    }

    public function createAdminNotificationToUsers(AdminNotificationCreateRequest $request): AdminNotificationToUsersResponse
    {
        $notification = $this->adminNotificationToUsersManager->createAdminNotificationToUsers($request);

        if ($notification) {
            // create local notification for captains if notifications send to them
            if ($request->getAppType() === NotificationConstant::APP_TYPE_CAPTAIN || $request->getAppType() === NotificationConstant::APP_TYPE_ALL) {
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
        if($notification === NotificationConstant::NOT_FOUND) {
        
            $item['state'] = NotificationConstant::NOT_FOUND;
        
            return $this->autoMapping->map("array", AdminNotificationToUsersNotFoundResponse::class, $item);
        }

        return $this->autoMapping->map(AdminNotificationToUsersEntity::class, AdminNotificationToUsersResponse::class, $notification);
    }

    public function deleteAdminNotification($id): AdminNotificationToUsersResponse|AdminNotificationToUsersNotFoundResponse
    {
        $notification = $this->adminNotificationToUsersManager->deleteAdminNotification($id);
        if($notification === NotificationConstant::NOT_FOUND) {
        
            $item['state'] = NotificationConstant::NOT_FOUND;
        
            return $this->autoMapping->map("array", AdminNotificationToUsersNotFoundResponse::class, $item);
        }

        return $this->autoMapping->map(AdminNotificationToUsersEntity::class, AdminNotificationToUsersResponse::class, $notification);
    }

    public function getAllNotificationsForAdmin(): ?array
    {
        $response = [];
        $notifications = $this->adminNotificationToUsersManager->getAllNotificationsForAdmin();
     
        foreach($notifications as $notification) {

        $response[] = $this->autoMapping->map("array", AdminNotificationsResponse::class, $notification);
        }

        return $response;
    }

    public function getNotificationByIdForAdmin($id): ?AdminNotificationsResponse
    {
        $notification = $this->adminNotificationToUsersManager->getNotificationByIdForAdmin($id);
     
        return $this->autoMapping->map(AdminNotificationToUsersEntity::class, AdminNotificationsResponse::class, $notification);
    }

    public function createLocalNotificationForAllCaptainsByAdmin(string $title, array $message): array|string
    {
        return $this->adminNotificationLocalService->initializeAndCreateLocalNotificationForAllCaptainsByAdmin($title, $message);
    }
}
