<?php

namespace App\Service\Admin\Notification\Local;

use App\Constant\Captain\CaptainConstant;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Notification\NotificationTokenConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Constant\User\UserRoleConstant;
use App\Manager\Admin\Notification\Local\AdminNotificationLocalManager;
use App\Request\Admin\Notification\Local\LocalNotificationCreateByAdminRequest;
use App\Service\Admin\User\AdminUserGetService;

class AdminNotificationLocalService
{
    private AdminUserGetService $adminUserGetService;
    private AdminNotificationLocalManager $adminNotificationLocalManager;

    public function __construct(AdminUserGetService $adminUserGetService, AdminNotificationLocalManager $adminNotificationLocalManager)
    {
        $this->adminUserGetService = $adminUserGetService;
        $this->adminNotificationLocalManager = $adminNotificationLocalManager;
    }

    public function initializeAndCreateLocalNotificationForAllCaptainsByAdmin(string $title, array $message): array|string
    {
        $captainsUsersIDs = $this->getUserIdOfAllCaptainsForAdmin();

        if (count($captainsUsersIDs) > 0) {
            $requestsArray = [];

            foreach ($captainsUsersIDs as $captainUserId) {
                $localNotificationByAdminCreateRequest = new LocalNotificationCreateByAdminRequest();

                // store the id of the user record in the message field
                $message['captainUserId'] = $captainUserId['id'];

                $localNotificationByAdminCreateRequest->setTitle($title);
                $localNotificationByAdminCreateRequest->setUserId($captainUserId['id']);
                $localNotificationByAdminCreateRequest->setMessage($message);
                $localNotificationByAdminCreateRequest->setAppType(NotificationTokenConstant::APP_TYPE_CAPTAIN);

                $requestsArray[] = $localNotificationByAdminCreateRequest;
            }

            return $this->adminNotificationLocalManager->createLocalNotificationForUsersByAdmin($requestsArray);
        }

        return UserReturnResultConstant::USER_NOT_FOUND_RESULT;
    }

    public function getUserIdOfAllCaptainsForAdmin(): array
    {
        return $this->adminUserGetService->getUsersIDsByRoleForAdmin(UserRoleConstant::ROLE_CAPTAIN);
    }
}
