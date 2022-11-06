<?php

namespace App\Service\Main;

use App\AutoMapping;
use App\Constant\Main\BackendHealthStatusConstant;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Notification\NotificationTokenConstant;
use App\Constant\Order\OrderResultConstant;
use App\Constant\Order\OrderStateConstant;
use App\Entity\OrderEntity;
use App\Manager\Main\MainManager;
use App\Request\Main\OrderStateUpdateBySuperAdminRequest;
use App\Request\User\UserPasswordUpdateBySuperAdminRequest;
use App\Response\Main\OrderStateUpdateBySuperAdminResponse;
use App\Response\User\UserRegisterResponse;
use App\Service\Notification\NotificationLocalService;
use App\Service\User\UserService;

class MainService
{
    private UserService $userService;
    private MainManager $mainManager;
    private AutoMapping $autoMapping;
    private NotificationLocalService $notificationLocalService;

    public function __construct(UserService $userService, MainManager $mainManager, AutoMapping $autoMapping, NotificationLocalService $notificationLocalService)
    {
        $this->userService = $userService;
        $this->mainManager = $mainManager;
        $this->autoMapping = $autoMapping;
        $this->notificationLocalService = $notificationLocalService;
    }

    public function checkBackendHealth($userId): ?array
    {
        $response = [];

        $userRole = $this->userService->getUserRoleByUserId($userId);

        if ($userRole) {
            $response['userRole'] = $userRole['roles'];
        }

        $response['result'] = BackendHealthStatusConstant::HEART_IS_BEATING_STATUS;

        return $response;
    }

    public function filterUsersBySuperAdmin($request): array
    {
        return $this->userService->filterUsersBySuperAdmin($request);
    }

    public function updateUserPasswordBySuperAdmin(UserPasswordUpdateBySuperAdminRequest $request): string|UserRegisterResponse
    {
        return $this->userService->updateUserPasswordBySuperAdmin($request);
    }

    public function deletePackagesAndSubscriptions(): \Exception|string
    {
        return $this->mainManager->deletePackagesAndSubscriptions();
    }

    public function updateOrderStateBySuperAdmin(OrderStateUpdateBySuperAdminRequest $request)
    {
        $orderResult = $this->mainManager->updateOrderStateBySuperAdmin($request);

        if($orderResult === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;

        } else {
            $captainId = 0;

            if($orderResult->getState() === OrderStateConstant::ORDER_STATE_DELIVERED) {
                // Here we pass store owner id as captain id just until we have captain section set
                $captainId = $orderResult->getStoreOwner()->getStoreOwnerId();
            }

            $this->notificationLocalService->createNotificationLocalBySuperAdmin($orderResult->getStoreOwner()->getStoreOwnerId(), NotificationConstant::UPDATE_ORDER_TITLE,
                NotificationConstant::UPDATE_ORDER_SUCCESS, $orderResult->getState(), NotificationTokenConstant::APP_TYPE_STORE,
                $captainId, $orderResult->getId());

            return $this->autoMapping->map(OrderEntity::class, OrderStateUpdateBySuperAdminResponse::class, $orderResult);
        }
    }
}
