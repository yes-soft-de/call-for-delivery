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

class AdminNotificationToUsersService
{
    private $autoMapping;
    private $adminNotificationToUsersManager;

    public function __construct(AutoMapping $autoMapping, AdminNotificationToUsersManager $adminNotificationToUsersManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminNotificationToUsersManager = $adminNotificationToUsersManager;
    }

    public function createAdminNotificationToUsers(AdminNotificationCreateRequest $request): AdminNotificationToUsersResponse
    {
        $notification = $this->adminNotificationToUsersManager->createAdminNotificationToUsers($request);

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
}
