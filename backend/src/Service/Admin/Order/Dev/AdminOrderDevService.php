<?php

namespace App\Service\Admin\Order\Dev;

use App\AutoMapping;
use App\Constant\GeoDistance\GeoDistanceResultConstant;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Notification\NotificationTokenConstant;
use App\Constant\Order\OrderClientLocationConstant;
use App\Constant\Order\OrderCostDefaultValueConstant;
use App\Constant\Order\OrderIsHideConstant;
use App\Constant\Order\OrderNoteDefaultValueConstant;
use App\Constant\Order\OrderRecipientDefaultValueConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Constant\OrderLog\OrderLogActionTypeConstant;
use App\Constant\OrderLog\OrderLogCreatedByUserTypeConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Constant\Subscription\SubscriptionConstant;
use App\Entity\OrderEntity;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionDetailsEntity;
use App\Manager\Admin\Order\AdminOrderManager;
use App\Request\Admin\Order\Dev\OrderDevCreateByAdminRequest;
use App\Request\Admin\Order\TestingOrderCreateByAdminRequest;
use App\Request\Admin\Subscription\AdminCalculateCostDeliveryOrderRequest;
use App\Response\Admin\Order\TestingOrderCreateByAdminResponse;
use App\Response\OrderTimeLine\OrderLogsResponse;
use App\Response\Subscription\CalculateCostDeliveryOrderResponse;
use App\Response\Subscription\CanCreateOrderResponse;
use App\Service\Admin\StoreOwner\AdminStoreOwnerProfileGetService;
use App\Service\Admin\StoreOwnerBranch\AdminStoreOwnerBranchGetService;
use App\Service\Admin\StoreOwnerSubscription\AdminStoreSubscriptionService;
use App\Service\GeoDistance\GeoDistanceService;
use App\Service\Notification\NotificationLocalService;
use App\Service\OrderLog\OrderLogService;
use App\Service\OrderTimeLine\OrderTimeLineService;
use App\Service\Subscription\SubscriptionService;
use DateTime;
use DateTimeInterface;

class AdminOrderDevService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminStoreOwnerProfileGetService $adminStoreOwnerProfileGetService,
        private AdminStoreOwnerBranchGetService $adminStoreOwnerBranchGetService,
        private AdminStoreSubscriptionService $adminStoreSubscriptionService,
        private SubscriptionService $subscriptionService,
        private GeoDistanceService $geoDistanceService,
        private NotificationLocalService $notificationLocalService,
        private OrderTimeLineService $orderTimeLineService,
        private OrderLogService $orderLogService,
        private AdminOrderManager $adminOrderManager
    )
    {
    }

    public function getStoreOwnerProfileEntityByIdForAdmin(int $storeOwnerProfileId): string|StoreOwnerProfileEntity
    {
        return $this->adminStoreOwnerProfileGetService->getStoreOwnerProfileEntityByIdForAdmin($storeOwnerProfileId);
    }

    public function getStoreBranchEntityById(int $branchId): StoreOwnerBranchEntity|string
    {
        return $this->adminStoreOwnerBranchGetService->getStoreBranchEntityById($branchId);
    }

    /**
     * Creates log of the action on order
     */
    public function createOrderLogMessageViaOrderEntityAndByAdmin(OrderEntity $orderEntity, int $userId)
    {
        $this->orderLogService->createOrderLogMessage($orderEntity, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
            OrderLogActionTypeConstant::CANCEL_ORDER_BY_ADMIN_ACTION_CONST, [], null, null);
    }

    public function createOrderLogViaOrderEntity(OrderEntity $orderEntity): OrderLogsResponse
    {
        return $this->orderTimeLineService->createOrderLogsRequest($orderEntity);
    }

    public function createLocalNotificationForStore(int $storeOwnerUserId, string $title, string $text, int $orderId)
    {
        $this->notificationLocalService->createNotificationLocal($storeOwnerUserId, $title, $text, NotificationTokenConstant::APP_TYPE_STORE, $orderId);
    }

    /**
     * Note: factor is the parameter that we want to subtract/add from/to remaining cars field
     */
    public function updateRemainingOrdersOfStoreSubscriptionByAdmin(int $storeOwnerProfileId, DateTimeInterface $orderCreationDate, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        return $this->adminStoreSubscriptionService->handleUpdatingRemainingOrdersOfStoreSubscriptionByAdmin($storeOwnerProfileId,
            $orderCreationDate, $operationType, $factor);
    }

    /**
     * Get the distance between two locations of type array for admin
     */
    public function getDistanceBetweenTwoLocations(array $fromLocation, array $toLocation): float|int
    {
        $result = $this->geoDistanceService->getGeoDistanceBetweenTwoLocations($fromLocation['lat'], $fromLocation['lon'],
            $toLocation['lat'], $toLocation['lon']);

        if (($result === GeoDistanceResultConstant::BAD_REQUEST_CONST) ||
            ($result === GeoDistanceResultConstant::CONTENT_CAN_NOT_BE_DECODED)) {
            return GeoDistanceResultConstant::DESTINATION_COULD_NOT_BE_CALCULATED;
        }

        // get the distance value from the resulted response
        return (float) $result->distance;
    }

    public function calculateCostDeliveryOrder(AdminCalculateCostDeliveryOrderRequest $request): CalculateCostDeliveryOrderResponse
    {
        return $this->adminStoreSubscriptionService->calculateCostDeliveryOrderForAdmin($request);
    }

    public function getNewAdminCalculateCostDeliveryOrderRequestObject(): AdminCalculateCostDeliveryOrderRequest
    {
        return new AdminCalculateCostDeliveryOrderRequest();
    }

    /**
     * Calculate the delivery cost according to store owner profile id and distance, and return the total value of
     * the delivery cost
     */
    public function calculateDeliveryCostByStoreOwnerProfileIdAndDistance(int $storeOwnerProfileId, float $distance): float
    {
        $adminCalculateCostDeliveryOrderRequest = $this->getNewAdminCalculateCostDeliveryOrderRequestObject();

        $adminCalculateCostDeliveryOrderRequest->setStoreOwnerProfileId($storeOwnerProfileId);
        $adminCalculateCostDeliveryOrderRequest->setStoreBranchToClientDistance($distance);

        $adminCalculateCostDeliveryOrderRequest = $this->calculateCostDeliveryOrder($adminCalculateCostDeliveryOrderRequest);

        return $adminCalculateCostDeliveryOrderRequest->total;
    }

    /**
     * Get random value of array
     */
    public function getRandomArrayValueOfArray(array $inputArray)
    {
        return $inputArray[array_rand($inputArray)];
    }

    /**
     * Create order/s by admin for testing/debugging purposes
     */
    public function createDevOrderByAdmin(TestingOrderCreateByAdminRequest $request, int $userId): CanCreateOrderResponse|array|string
    {
        $response = [];

        if ((! $request->getOrdersCount())
            || ($request->getOrdersCount() <= 0)
            || ($request->getOrdersCount() > 3)) {
            $request->setOrdersCount(1);
        }

        // 1 check if store owner profile does exist
        $storeOwnerProfile = $this->getStoreOwnerProfileEntityByIdForAdmin($request->getStoreOwner());

        if ($storeOwnerProfile === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        // 2 check if store branch exist
        $branch = $this->getStoreBranchEntityById($request->getBranch());

        if ($branch === StoreOwnerBranch::BRANCH_NOT_FOUND) {
            return StoreOwnerBranch::BRANCH_NOT_FOUND;
        }

        $request->setStoreOwner($storeOwnerProfile);
        $request->setBranch($branch);

        for ($counter = 0; $counter < $request->getOrdersCount(); $counter++) {
            // 3 check if store has current active subscription
            $canCreateOrder = $this->subscriptionService->canCreateOrder($storeOwnerProfile->getStoreOwnerId());

            if ($canCreateOrder === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS
                || $canCreateOrder->canCreateOrder === SubscriptionConstant::CAN_NOT_CREATE_ORDER) {
                return $canCreateOrder;
            }

            $orderCreateByAdminRequest = $this->autoMapping->map(TestingOrderCreateByAdminRequest::class,
                OrderDevCreateByAdminRequest::class, $request);

            // 4 check if store subscription remaining cars finished
            $orderCreateByAdminRequest->setIsHide(OrderIsHideConstant::ORDER_SHOW);

            if ($canCreateOrder->subscriptionStatus === SubscriptionConstant::CARS_FINISHED) {
                $orderCreateByAdminRequest->setIsHide(OrderIsHideConstant::ORDER_HIDE_TEMPORARILY);
            }

            // 5 set the delivery date equals to current datetime + 3 minutes just for affording the late in persisting
            // the order to the database if it is happened
            $orderCreateByAdminRequest->setDeliveryDate((new DateTime('+ 3 minutes'))->format('Y-m-d H:i:s'));

            $orderCreateByAdminRequest->setPayment(OrderTypeConstant::ORDER_PAYMENT_CASH);
            $orderCreateByAdminRequest->setOrderCost($this->getRandomArrayValueOfArray(OrderCostDefaultValueConstant::ORDER_VALUE_ARRAY_CONST));
            $orderCreateByAdminRequest->setNote($this->getRandomArrayValueOfArray(OrderNoteDefaultValueConstant::ORDER_NOTE_DEFAULT_VALUE_ARRAY_CONST));
            $orderCreateByAdminRequest->setDestination($this->getRandomArrayValueOfArray(OrderClientLocationConstant::ORDER_CLIENT_LOCATION_ARRAY_CONST));
            $orderCreateByAdminRequest->setRecipientName($this->getRandomArrayValueOfArray(OrderRecipientDefaultValueConstant::ORDER_RECIPIENT_NAME_DEFAULT_VALUE_ARRAY_CONST));
            $orderCreateByAdminRequest->setRecipientPhone($this->getRandomArrayValueOfArray(OrderRecipientDefaultValueConstant::ORDER_RECIPIENT_PHONE_DEFAULT_VALUE_ARRAY_CONST));
            $orderCreateByAdminRequest->setDetail($this->getRandomArrayValueOfArray(OrderNoteDefaultValueConstant::ORDER_NOTE_DEFAULT_VALUE_ARRAY_CONST));

            // 6 calculate the distance between the store's branch and the client location
            $distance = $this->getDistanceBetweenTwoLocations($branch->getLocation(), $orderCreateByAdminRequest->getDestination());
            $orderCreateByAdminRequest->setStoreBranchToClientDistance($distance);

            // 7 calculate the delivery cost
            $orderCreateByAdminRequest->setDeliveryCost($this->calculateDeliveryCostByStoreOwnerProfileIdAndDistance($storeOwnerProfile->getId(),
                $distance));

            // 8 create order record
            $order = $this->adminOrderManager->createOrderDevByAdmin($orderCreateByAdminRequest);

            if ($order) {
                // 9 update the remaining orders of the store's subscription
                $this->updateRemainingOrdersOfStoreSubscriptionByAdmin($storeOwnerProfile->getId(), $order->getCreatedAt(),
                    SubscriptionConstant::OPERATION_TYPE_SUBTRACTION, 1);

                // 10 create local notification for the store
                $this->createLocalNotificationForStore($storeOwnerProfile->getId(), NotificationConstant::NEW_ORDER_TITLE,
                    NotificationConstant::CREATE_ORDER_SUCCESS, $order->getId());

                // 11 create order timeline
                $this->createOrderLogViaOrderEntity($order);

                // 12 save log of the action on order
                $this->createOrderLogMessageViaOrderEntityAndByAdmin($order, $userId);

                // 13 prepare the response
                $response[] = $this->autoMapping->map(OrderEntity::class, TestingOrderCreateByAdminResponse::class,
                    $order);
            }
        }

        return $response;
    }
}