<?php

namespace App\Service\OrderDistanceConflict;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\Notification\DashboardLocalNotification\DashboardLocalNotificationAppTypeConstant;
use App\Constant\Notification\DashboardLocalNotification\DashboardLocalNotificationMessageConstant;
use App\Constant\Notification\DashboardLocalNotification\DashboardLocalNotificationTitleConstant;
use App\Constant\Notification\NotificationFirebaseConstant;
use App\Constant\Order\OrderResultConstant;
use App\Constant\OrderDistanceConflict\OrderDistanceConflictResultConstant;
use App\Constant\StoreOrderDetails\StoreOrderDetailsConstant;
use App\Entity\OrderDistanceConflictEntity;
use App\Entity\OrderEntity;
use App\Manager\OrderDistanceConflict\OrderDistanceConflictManager;
use App\Request\OrderDistanceConflict\OrderDistanceConflictCreateByCaptainRequest;
use App\Response\OrderDistanceConflict\OrderDistanceConflictCreateByCaptainResponse;
use App\Service\Captain\CaptainGetService;
use App\Service\Notification\DashboardLocalNotification\DashboardLocalNotificationService;
use App\Service\Notification\NotificationFirebaseService;
use App\Service\Order\OrderGetService;
use App\Service\StoreOrderDetails\StoreOrderDetailsGetService;

class OrderDistanceConflictService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private OrderGetService $orderGetService,
        private CaptainGetService $captainGetService,
        private StoreOrderDetailsGetService $storeOrderDetailsGetService,
        private DashboardLocalNotificationService $dashboardLocalNotificationService,
        private NotificationFirebaseService $notificationFirebaseService,
        private OrderDistanceConflictManager $orderDistanceConflictManager
    )
    {
    }

    /**
     * Sends a firebase notification to admin about an order
     */
    public function sendFirebaseNotificationToAdminAboutOrder(int $orderId, string $text)
    {
        try {
            $this->notificationFirebaseService->notificationToAdmin($orderId, $text);

        } catch (\Exception $exception) {
            error_log($exception);
        }
    }

    /**
     * Return an order distance conflict object by order id
     */
    public function getOrderDistanceConflictByOrderId(int $orderId): int|OrderDistanceConflictEntity
    {
        $orderDistanceConflict = $this->orderDistanceConflictManager->getOrderDistanceConflictByOrderId($orderId);

        if (! $orderDistanceConflict) {
            return OrderDistanceConflictResultConstant::ORDER_DISTANCE_CONFLICT_NOT_EXIST_CONST;
        }

        return $orderDistanceConflict;
    }

    /**
     * Creates local notification for admin by captain
     */
    public function createDashboardLocalNotificationByCaptain(string $title, array $message, int $adminUserId = null, int $orderId = null)
    {
        $this->dashboardLocalNotificationService->createOrderLogMessage($title, $message,
            DashboardLocalNotificationAppTypeConstant::CAPTAIN_APP_TYPE_CONST, $adminUserId, $orderId);
    }

    /**
     * Returns order entity object by order id
     */
    public function getOrderEntityById(int $orderId): OrderEntity|string
    {
        return $this->orderGetService->getOrderEntityById($orderId);
    }

    /**
     * Returns captain profile id by user id
     */
    public function getCaptainProfileIdByCaptainUserId(int $captainUserId): int|string
    {
        return $this->captainGetService->getCaptainProfileIdByCaptainUserId($captainUserId);
    }

    /**
     * Returns the destination of a normal order by order id
     * normal order (not a bid order)
     */
    public function getNormalOrderDestinationByOrderId(int $orderId): array|int
    {
        return $this->storeOrderDetailsGetService->getNormalOrderDestinationByOrderId($orderId);
    }

    /**
     * Creates an order distance conflict by captain
     */
    public function createOrderDistanceConflictByCaptain(OrderDistanceConflictCreateByCaptainRequest $request, int $captainUserId): string|int|OrderDistanceConflictCreateByCaptainResponse
    {
        // First, check if captain had created an order distance conflict for the same order before.
        $orderDistanceConflict = $this->getOrderDistanceConflictByOrderId($request->getOrderId());

        if ($orderDistanceConflict !== OrderDistanceConflictResultConstant::ORDER_DISTANCE_CONFLICT_NOT_EXIST_CONST) {
            return OrderDistanceConflictResultConstant::ORDER_DISTANCE_ALREADY_EXIST_CONST;
        }

        // Get and set order entity
        $orderEntity = $this->getOrderEntityById($request->getOrderId());

        if ($orderEntity === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        $request->setOrderId($orderEntity);

        // Set old distance
        $request->setOldDistance($orderEntity->getStoreBranchToClientDistance());

        // Get and set captain profile id
        $captainProfileId = $this->getCaptainProfileIdByCaptainUserId($captainUserId);

        if ($captainProfileId === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
        }

        $request->setConflictIssuedBy($captainProfileId);

        // Get and set old destination
        $orderDestination = $this->getNormalOrderDestinationByOrderId($orderEntity->getId());

        if ($orderDestination === StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND) {
            return StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND;
        }

        $request->setOldDestination($orderDestination);

        $orderDistanceConflict = $this->orderDistanceConflictManager->createOrderDistanceConflictByCaptain($request);

        // 7. Create notifications
        // Create local notification for admin
        $this->createDashboardLocalNotificationByCaptain(DashboardLocalNotificationTitleConstant::ORDER_DISTANCE_CONFLICT_CREATED_BY_CAPTAIN_TITLE_CONST,
            ["text" => DashboardLocalNotificationMessageConstant::ORDER_DISTANCE_CONFLICT_CREATED_BY_CAPTAIN_TEXT_CONST.$orderEntity->getId()],
            null, $orderEntity->getId());
        // Create firebase notification for admin
        $this->sendFirebaseNotificationToAdminAboutOrder($orderEntity->getId(),
            NotificationFirebaseConstant::ORDER_DISTANCE_CONFLICT_CREATE_BY_CAPTAIN_MESSAGE_CONST);

        return $this->autoMapping->map(OrderDistanceConflictEntity::class, OrderDistanceConflictCreateByCaptainResponse::class,
            $orderDistanceConflict);
    }
}
