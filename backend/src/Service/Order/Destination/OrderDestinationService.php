<?php

namespace App\Service\Order\Destination;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\GeoDistance\GeoDistanceResultConstant;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Notification\NotificationFirebaseConstant;
use App\Constant\Order\OrderDestinationConstant;
use App\Constant\Order\OrderResultConstant;
use App\Constant\Order\OrderStateConstant;
use App\Constant\OrderLog\OrderLogActionTypeConstant;
use App\Constant\OrderLog\OrderLogCreatedByUserTypeConstant;
use App\Constant\StoreOrderDetails\StoreOrderDetailsConstant;
use App\Entity\CaptainFinancialDuesEntity;
use App\Entity\OrderEntity;
use App\Entity\StoreOrderDetailsEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Request\Order\Destination\OrderStoreBranchToClientDistanceAdditionByCaptainUpdateRequest;
use App\Request\Order\Destination\StoreOrderDetailsDifferentReceiverDestinationUpdateByOrderIdRequest;
use App\Request\Order\OrderDeliveryCostUpdateRequest;
use App\Request\Order\OrderStoreBranchToClientDistanceUpdateRequest;
use App\Request\Subscription\CalculateCostDeliveryOrderRequest;
use App\Response\Order\Destination\OrderDestinationUpdateResponse;
use App\Response\Order\OrderDeliveryCostUpdateResponse;
use App\Response\Subscription\CalculateCostDeliveryOrderResponse;
use App\Service\CaptainFinancialSystem\CaptainFinancialDuesService;
use App\Service\GeoDistance\GeoDistanceService;
use App\Service\Notification\NotificationFirebaseService;
use App\Service\Notification\NotificationLocalService;
use App\Service\Order\OrderService;
use App\Service\Order\StoreOrderDetailsService;
use App\Service\OrderLog\OrderLogService;
use App\Service\Subscription\SubscriptionService;
use DateTimeInterface;
use Doctrine\ORM\EntityManagerInterface;

class OrderDestinationService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private GeoDistanceService $geoDistanceService,
        private OrderService $orderService,
        private StoreOrderDetailsService $storeOrderDetailsService,
        private OrderLogService $orderLogService,
        private SubscriptionService $subscriptionService,
        private CaptainFinancialDuesService $captainFinancialDuesService,
        private NotificationLocalService $notificationLocalService,
        private NotificationFirebaseService $notificationFirebaseService
    )
    {
    }

    /**
     * This function will do:
     * 1. Calculate the new storeBranchToClientDistance and update it beside an explanation about the difference
     * 2. Save current client destination in the details field of the order log before being updated by the new one
     * 3. Update differentReceiverDestination + destination in storeOrderDetails
     * 4. Re-calculate delivery cost depending on the new storeBranchToClientDistance
     * 5. Re-calculate captain financial dues (if order had been delivered)
     * 6. Create notifications for store (local + firebase)
     */
    public function updateNormalOrderDestinationByNewClientLocationAddition(OrderStoreBranchToClientDistanceAdditionByCaptainUpdateRequest $request): int|string|OrderDestinationUpdateResponse
    {
        if (count($request->getDestination()) === 0) {
            return StoreOrderDetailsConstant::STORE_ORDER_DETAILS_DESTINATION_EMPTY_CONST;
        }

        // start transaction commit ...
        $this->entityManager->getConnection()->beginTransaction();

        try {
            // 1. Calculate the new storeBranchToClientDistance and update it beside an explanation about the difference
            $storeBranchToClientDistanceUpdateResult = $this->updateStoreBranchToClientDistanceByAddNewDistance($request);

            if ($storeBranchToClientDistanceUpdateResult === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
                return OrderResultConstant::ORDER_NOT_FOUND_RESULT;

            } elseif ($storeBranchToClientDistanceUpdateResult === StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND) {
                return StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND;

            } elseif ($storeBranchToClientDistanceUpdateResult === GeoDistanceResultConstant::DESTINATION_COULD_NOT_BE_CALCULATED) {
                return GeoDistanceResultConstant::DESTINATION_COULD_NOT_BE_CALCULATED;

            } elseif ($storeBranchToClientDistanceUpdateResult === GeoDistanceResultConstant::DESTINATION_HAS_NULL_VALUE) {
                return GeoDistanceResultConstant::DESTINATION_HAS_NULL_VALUE;
            }

            // 2. Save current client destination in the details field of the order log before being updated by the new one
            $orderLogSaveResult = $this->createOrderLogWithCurrentDestination($request->getId());

            if ($orderLogSaveResult === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
                return OrderResultConstant::ORDER_NOT_FOUND_RESULT;

            } elseif ($orderLogSaveResult === StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND) {
                return StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND;
            }

            // 3. Update differentReceiverDestination + destination in order to appear the order for admin in the conflicted orders list
            $storeOrderDetailsDestinationUpdateResult = $this->updateStoreOrderDetailsDestinationAndDifferentReceiverDestination($request);

            if ($storeOrderDetailsDestinationUpdateResult === StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND) {
                return StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND;
            }

            // 4. Re-calculate delivery cost depending on the new storeBranchToClientDistance
            $updateOrderDeliveryCostResult = $this->updateOrderDeliveryCost($storeBranchToClientDistanceUpdateResult->getId(),
                $storeBranchToClientDistanceUpdateResult->getStoreBranchToClientDistance());

            if ($updateOrderDeliveryCostResult === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
                return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
            }

            // 5. Re-calculate captain financial dues (if order had been delivered)
            $updateCaptainFinancialDuesResult = $this->checkIfCaptainFinancialDuesNeedToBeUpdatedByOrderState($storeBranchToClientDistanceUpdateResult->getCaptainId()->getCaptainId(),
                $storeBranchToClientDistanceUpdateResult->getState(), $storeBranchToClientDistanceUpdateResult->getId(),
                $storeBranchToClientDistanceUpdateResult->getCreatedAt());

            if ($updateCaptainFinancialDuesResult === CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM) {
                return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;

            } elseif ($updateCaptainFinancialDuesResult === CaptainFinancialDues::FINANCIAL_NOT_FOUND) {
                return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
            }

            // 6. Create notifications
            // Create local notification for store
            $this->createLocalNotificationForStore($storeBranchToClientDistanceUpdateResult->getStoreOwner()->getStoreOwnerId(),
                $storeBranchToClientDistanceUpdateResult->getId(), NotificationConstant::ORDER_DESTINATION_DIFFERENT_TITLE_CONST,
                NotificationConstant::ORDER_DESTINATION_ADDITION_BY_CAPTAIN_MESSAGE_CONST.$storeBranchToClientDistanceUpdateResult->getId(),);

            // commit the transaction
            $this->entityManager->getConnection()->commit();

        } catch (\Exception $e) {
            $this->entityManager->getConnection()->rollBack();
            throw $e;
        }

        // NOTE: sending firebase statement had been separated into another try-catch block in order to avoid any problem
        // in the firebase that could lead to rollback previous transaction
        try {
            $this->sendFirebaseNotificationToUser($storeBranchToClientDistanceUpdateResult->getStoreOwner()->getStoreOwnerId(),
                $storeBranchToClientDistanceUpdateResult->getId(), NotificationFirebaseConstant::ORDER_DESTINATION_ADDITION_BY_CAPTAIN_MESSAGE_CONST);

            return $this->autoMapping->map(OrderEntity::class, OrderDestinationUpdateResponse::class, $storeBranchToClientDistanceUpdateResult);

        } catch (\Exception $e) {
            throw $e;
        }
    }

    // Get the distance between two locations of type array
    public function getDistanceBetweenTwoLocations(array $fromLocation, array $toLocation): float|int
    {
        if ((! $fromLocation['lat']) || (! $fromLocation['lon']) || (! $toLocation['lat']) || (! $toLocation['lon'])) {
            return GeoDistanceResultConstant::DESTINATION_HAS_NULL_VALUE;
        }

        $result = $this->geoDistanceService->getGeoDistanceBetweenTwoLocations($fromLocation['lat'], $fromLocation['lon'],
            $toLocation['lat'], $toLocation['lon']);

        if (($result === GeoDistanceResultConstant::BAD_REQUEST_CONST)
            || ($result === GeoDistanceResultConstant::CONTENT_CAN_NOT_BE_DECODED)) {
            return GeoDistanceResultConstant::DESTINATION_COULD_NOT_BE_CALCULATED;
        }

        // get the distance value from the resulted response
        return (float) $result->distance;
    }

    public function getStoreBranchToClientDistanceByOrderId(int $orderId): float|string
    {
        return $this->orderService->getStoreBranchToClientDistanceByOrderId($orderId);
    }

    public function getDistanceToBeAddToStoreBranchToClientDistance(int $orderId, array $newDestination): float|int
    {
        $currentOrderDestination = $this->getNormalOrderDestinationByOrderId($orderId);

        if ($currentOrderDestination === StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND) {
            return StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND;
        }

        $distanceToBeAdd = $this->getDistanceBetweenTwoLocations($newDestination, $currentOrderDestination);

        if ($distanceToBeAdd === GeoDistanceResultConstant::DESTINATION_COULD_NOT_BE_CALCULATED) {
            return GeoDistanceResultConstant::DESTINATION_COULD_NOT_BE_CALCULATED;

        } elseif ($distanceToBeAdd === GeoDistanceResultConstant::DESTINATION_HAS_NULL_VALUE) {
            return GeoDistanceResultConstant::DESTINATION_HAS_NULL_VALUE;
        }

        return $distanceToBeAdd;
    }

    public function getNewStoreBranchToClientDistance(int $orderId, array $newDestination): float|int|string
    {
        $distanceToBeAdd = $this->getDistanceToBeAddToStoreBranchToClientDistance($orderId, $newDestination);

        if ($distanceToBeAdd === StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND) {
            return StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND;

        } elseif ($distanceToBeAdd === GeoDistanceResultConstant::DESTINATION_COULD_NOT_BE_CALCULATED) {
            return GeoDistanceResultConstant::DESTINATION_COULD_NOT_BE_CALCULATED;

        } elseif ($distanceToBeAdd === GeoDistanceResultConstant::DESTINATION_HAS_NULL_VALUE) {
            return GeoDistanceResultConstant::DESTINATION_HAS_NULL_VALUE;
        }

        $currentStoreBranchToClientDistance = $this->getStoreBranchToClientDistanceByOrderId($orderId);

        if ($currentStoreBranchToClientDistance === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        return $distanceToBeAdd + $currentStoreBranchToClientDistance;
    }

    public function updateStoreBranchToClientDistanceByAddNewDistance(OrderStoreBranchToClientDistanceAdditionByCaptainUpdateRequest $request): OrderEntity|int|string
    {
        $newStoreBranchToClientDistance = $this->getNewStoreBranchToClientDistance($request->getId(), $request->getDestination());

        if ($newStoreBranchToClientDistance === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;

        } elseif ($newStoreBranchToClientDistance === StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND) {
            return StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND;

        } elseif ($newStoreBranchToClientDistance === GeoDistanceResultConstant::DESTINATION_COULD_NOT_BE_CALCULATED) {
            return GeoDistanceResultConstant::DESTINATION_COULD_NOT_BE_CALCULATED;

        } elseif ($newStoreBranchToClientDistance === GeoDistanceResultConstant::DESTINATION_HAS_NULL_VALUE) {
            return GeoDistanceResultConstant::DESTINATION_HAS_NULL_VALUE;
        }

        $storeBranchToClientDistanceUpdateRequest = $this->autoMapping->map(OrderStoreBranchToClientDistanceAdditionByCaptainUpdateRequest::class,
            OrderStoreBranchToClientDistanceUpdateRequest::class, $request);

        $storeBranchToClientDistanceUpdateRequest->setStoreBranchToClientDistance($newStoreBranchToClientDistance);

        return $this->orderService->updateStoreBranchToClientDistanceByAddNewDistance($storeBranchToClientDistanceUpdateRequest);
    }

    public function updateStoreOrderDetailsDestinationAndDifferentReceiverDestination(OrderStoreBranchToClientDistanceAdditionByCaptainUpdateRequest $request): int|StoreOrderDetailsEntity
    {
        // storeOrderDetailsDestinationUpdateRequest
        $destinationUpdateRequest = $this->autoMapping->map(OrderStoreBranchToClientDistanceAdditionByCaptainUpdateRequest::class,
            StoreOrderDetailsDifferentReceiverDestinationUpdateByOrderIdRequest::class, $request);

        $destinationUpdateRequest->setOrderId($request->getId());
        // flag: indicate that the destination is different from previous one, and it had been updated by the captain
        $destinationUpdateRequest->setDifferentReceiverDestination(OrderDestinationConstant::ORDER_DESTINATION_IS_DIFFERENT_AND_UPDATED_BY_CAPTAIN_CONST);

        return $this->storeOrderDetailsService->updateStoreOrderDetailsDestinationAndDifferentReceiverDestination($destinationUpdateRequest);
    }

    public function getOrderEntityByOrderId(int $orderId): ?OrderEntity
    {
        return $this->orderService->getOrderEntityByOrderId($orderId);
    }

    public function createOrderLogWithDestinationByOrderEntity(OrderEntity $orderEntity, array $oldDestination)
    {
        $this->orderLogService->createOrderLogMessage($orderEntity, $orderEntity->getCaptainId()->getCaptainId(),
            OrderLogCreatedByUserTypeConstant::CAPTAIN_USER_TYPE_CONST,
            OrderLogActionTypeConstant::ORDER_OLD_DESTINATION_SAVED_CONST, ["oldDestination" => $oldDestination],
            null, null);
    }

    public function getNormalOrderDestinationByOrderId(int $orderId): array|int
    {
        return $this->storeOrderDetailsService->getNormalOrderDestinationByOrderId($orderId);
    }

    public function createOrderLogWithCurrentDestination(int $orderId): OrderEntity|int|string
    {
        // Get order entity first
        $order = $this->getOrderEntityByOrderId($orderId);

        if (! $order) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        // Get current destination
        $currentDestination = $this->getNormalOrderDestinationByOrderId($orderId);

        if ($currentDestination === StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND) {
            return StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND;
        }

        // Save a log with current destination
        $this->createOrderLogWithDestinationByOrderEntity($order, $currentDestination);

        return $order;
    }

    public function getStoreOwnerProfileByOrderId(int $orderId): string|StoreOwnerProfileEntity
    {
        return $this->orderService->getStoreOwnerProfileByOrderId($orderId);
    }

    public function getStoreOwnerUserIdByOrderId(int $orderId): string
    {
        $storeOwnerProfile = $this->getStoreOwnerProfileByOrderId($orderId);

        if ($storeOwnerProfile === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        return $storeOwnerProfile->getStoreOwnerId();
    }

    public function initializeCalculateCostDeliveryOrderRequest(float $storeBranchToClientDistance, int $storeOwnerUserId): CalculateCostDeliveryOrderRequest
    {
        $request = new CalculateCostDeliveryOrderRequest();

        $request->setStoreBranchToClientDistance($storeBranchToClientDistance);
        $request->setStoreOwner($storeOwnerUserId);

        return $request;
    }

    // Calculate order delivery cost
    public function calculateOrderDeliveryCost(int $orderId, float $storeBranchToClientDistance): CalculateCostDeliveryOrderResponse|string
    {
        $storeOwnerUserId = $this->getStoreOwnerUserIdByOrderId($orderId);

        if ($storeOwnerUserId === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        $calculateCostDeliveryOrderRequest = $this->initializeCalculateCostDeliveryOrderRequest($storeBranchToClientDistance,
            $storeOwnerUserId);

        return $this->subscriptionService->calculateCostDeliveryOrder($calculateCostDeliveryOrderRequest);
    }

    public function initializeOrderDeliveryCostUpdateRequest(int $orderId, float $deliveryCost): OrderDeliveryCostUpdateRequest
    {
        $request = new OrderDeliveryCostUpdateRequest();

        $request->setId($orderId);
        $request->setDeliveryCost($deliveryCost);

        return $request;
    }

    public function updateOrderDeliveryCost(int $orderId, float $storeBranchToClientDistance): string|OrderDeliveryCostUpdateResponse
    {
        $newOrderDeliveryCost = $this->calculateOrderDeliveryCost($orderId, $storeBranchToClientDistance);

        if ($newOrderDeliveryCost === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        $deliveryCostUpdateRequest = $this->initializeOrderDeliveryCostUpdateRequest($orderId, $newOrderDeliveryCost->total);

        return $this->orderService->updateOrderDeliveryCost($deliveryCostUpdateRequest);
    }

    public function updateCaptainFinancialDues(int $captainUserId, int $orderId = null, DateTimeInterface $orderCreatedAt = null): CaptainFinancialDuesEntity|int|string
    {
        return $this->captainFinancialDuesService->captainFinancialDues($captainUserId, $orderId, $orderCreatedAt);
    }

    public function checkIfCaptainFinancialDuesNeedToBeUpdatedByOrderState(int $captainUserId, string $orderState, int $orderId = null, DateTimeInterface $orderCreatedAt = null): CaptainFinancialDuesEntity|int|string
    {
        if ($orderState !== OrderStateConstant::ORDER_STATE_DELIVERED) {
            return OrderResultConstant::ORDER_IS_NOT_BEING_DELIVERED_YET_CONST;
        }

        return $this->updateCaptainFinancialDues($captainUserId, $orderId, $orderCreatedAt);
    }

    public function createLocalNotificationForStore(int $storeOwnerUserId, int $orderId, string $title, string $text)
    {
        $this->notificationLocalService->createNotificationLocal($storeOwnerUserId, $title, $text, $orderId);
    }

    public function sendFirebaseNotificationToUser(int $userId, int $orderId, string $text)
    {
        $this->notificationFirebaseService->notificationToUser($userId, $orderId, $text);
    }
}
