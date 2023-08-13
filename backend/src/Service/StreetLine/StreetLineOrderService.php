<?php

namespace App\Service\StreetLine;

use App\AutoMapping;
use App\Constant\ExternalDeliveryCompany\StreetLine\StreetLineCompanyConstant;
use App\Constant\ExternallyDeliveredOrder\ExternallyDeliveredOrderConstant;
use App\Constant\OrderLog\OrderLogActionTypeConstant;
use App\Constant\OrderLog\OrderLogCreatedByUserTypeConstant;
use App\Constant\Subscription\SubscriptionConstant;
use App\Entity\ExternallyDeliveredOrderEntity;
use App\Entity\OrderEntity;
use App\Entity\SubscriptionEntity;
use App\Request\StreetLine\StreetLineOrderStatusUpdateRequest;
use App\Response\StreetLine\StreetLineOrderStatusUpdateResponse;
use App\Service\ExternalOrderUpdateHandler\ExternalOrderUpdateHandlerService;
use App\Service\OrderLog\OrderLogService;
use App\Service\Subscription\SubscriptionService;
use DateTimeInterface;

class StreetLineOrderService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private ExternalOrderUpdateHandlerService $externalOrderUpdateHandlerService,
        private OrderLogService $orderLogService,
        private SubscriptionService $subscriptionService
    )
    {
    }

    /**
     * Updates order status by StreetLine Delivery Company
     */
    public function updateStreetLineOrderStatus(StreetLineOrderStatusUpdateRequest $request): int|StreetLineOrderStatusUpdateResponse
    {
        $order = $this->externalOrderUpdateHandlerService->handleStreetLineOrderStatusUpdate($request);

        if ($order === ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST) {
            return ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST;
        }
        // If order had been delivered, then update subscription cost of the store's subscription
        if ($request->getStatus() === StreetLineCompanyConstant::ORDER_DELIVERED_STATUS_CONST) {
            $this->handleUpdatingStoreSubscriptionCost($order->getOrderId()->getStoreOwner()->getId(),
                $order->getOrderId()->getCreatedAt(), SubscriptionConstant::OPERATION_TYPE_ADDITION,
                $order->getOrderId()->getDeliveryCost());
        }
        // save order log
        $this->createOrderLogMessageViaOrderEntityAndByStreetLineCompany($order->getOrderId(), [
            'externalCompanyName' => $order->getExternalDeliveryCompany()->getCompanyName()
        ]);

        return $this->autoMapping->map(ExternallyDeliveredOrderEntity::class, StreetLineOrderStatusUpdateResponse::class,
            $order);
    }

    public function createOrderLogMessageViaOrderEntityAndByStreetLineCompany(OrderEntity $orderEntity, array $details)
    {
        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($orderEntity, 2, OrderLogCreatedByUserTypeConstant::STREETLINE_EXTERNAL_DELIVERY_COMPANY_CONST,
            OrderLogActionTypeConstant::ORDER_STATUS_UPDATE_BY_STREETLINE_EXTERNAL_COMPANY_CONST, $details,
            null, null);
    }

    /**
     * Handles the updating of the subscriptionCost field of last store subscription
     */
    private function handleUpdatingStoreSubscriptionCost(
        int $storeOwnerProfileId,
        DateTimeInterface $orderCreatedAt,
        string $operationType,
        ?float $orderDeliveryCost = null
    ): SubscriptionEntity|int|string
    {
        return $this->subscriptionService->handleUpdatingStoreSubscriptionCost($storeOwnerProfileId, $orderCreatedAt,
            $operationType, $orderDeliveryCost);
    }
}
