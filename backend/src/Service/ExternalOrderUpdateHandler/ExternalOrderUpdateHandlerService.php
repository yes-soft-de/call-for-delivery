<?php

namespace App\Service\ExternalOrderUpdateHandler;

use App\AutoMapping;
use App\Constant\ExternalDeliveryCompany\Mrsool\MrsoolCompanyConstant;
use App\Constant\ExternallyDeliveredOrder\ExternallyDeliveredOrderConstant;
use App\Constant\Order\OrderStateConstant;
use App\Entity\ExternallyDeliveredOrderEntity;
use App\Entity\OrderEntity;
use App\Request\ExternallyDeliveredOrder\ExternallyDeliveredOrderStatusUpdateRequest;
use App\Request\Mrsool\MrsoolOrderStatusUpdateRequest;
use App\Service\ExternallyDeliveredOrder\ExternallyDeliveredOrderGetService;
use App\Service\ExternallyDeliveredOrder\ExternallyDeliveredOrderService;
use App\Service\Order\OrderService;

/**
 * Responsible for handling the update process of an externally delivered order
 * which initiated by the external company
 */
class ExternalOrderUpdateHandlerService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private ExternallyDeliveredOrderService $externallyDeliveredOrderService,
        private OrderService $orderService,
        private ExternallyDeliveredOrderGetService $externallyDeliveredOrderGetService
    )
    {
    }

    public function getExternallyDeliveredOrderByExternalOrderId(int $externalOrderId): ?ExternallyDeliveredOrderEntity
    {
        return $this->externallyDeliveredOrderGetService->getExternallyDeliveredOrderByExternalOrderId($externalOrderId);
    }

    public function updateExternallyDeliveredOrderStatus(MrsoolOrderStatusUpdateRequest $request): ExternallyDeliveredOrderEntity|int
    {
        // get externally delivered order id
        $externallyDeliveredOrder = $this->getExternallyDeliveredOrderByExternalOrderId($request->getId());

        if (! $externallyDeliveredOrder) {
            return ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST;
        }

        $request->setId($externallyDeliveredOrder->getId());

        $externallyDeliveredOrderStatusUpdateRequest = $this->autoMapping->map(MrsoolOrderStatusUpdateRequest::class,
            ExternallyDeliveredOrderStatusUpdateRequest::class, $request);

        return $this->externallyDeliveredOrderService->updateExternallyDeliveredOrderStatus($externallyDeliveredOrderStatusUpdateRequest);
    }

    public function getOrderStatusFromExternalOne(string $externalStatus, OrderEntity $orderEntity): string
    {
        // 1 compare status
        $orderStatus = $orderEntity->getState();

        if (($externalStatus === MrsoolCompanyConstant::COURIER_PENDING_ORDER_STATUS_CONST)
            || ($externalStatus === MrsoolCompanyConstant::EXPIRED_ORDER_STATUS_CONST)) {
            $orderStatus = OrderStateConstant::ORDER_STATE_PENDING;

        } elseif ($externalStatus === MrsoolCompanyConstant::COLLECTING_ORDER_STATUS_CONST) {
            $orderStatus = OrderStateConstant::ORDER_STATE_ON_WAY;

        } elseif (($externalStatus === MrsoolCompanyConstant::DELIVERING_ORDER_STATUS_CONST)
            || ($externalStatus === MrsoolCompanyConstant::DROPOFF_ARRIVED_ORDER_STATUS_CONST)) {
            $orderStatus = OrderStateConstant::ORDER_STATE_ONGOING;

        } elseif ($externalStatus === MrsoolCompanyConstant::CANCELED_ORDER_STATUS_CONST) {
            $orderStatus = OrderStateConstant::ORDER_STATE_CANCEL;

        } elseif ($externalStatus === MrsoolCompanyConstant::DELIVERED_ORDER_STATUS_CONST) {
            $orderStatus = OrderStateConstant::ORDER_STATE_DELIVERED;
        }

        return $orderStatus;
    }

    public function updateOrderStateByOrderEntityAndNewState(OrderEntity $orderEntity, string $state): OrderEntity
    {
        return $this->orderService->updateOrderStateByOrderEntityAndNewState($orderEntity, $state);
    }

    public function handleMrsoolOrderStatusUpdate(MrsoolOrderStatusUpdateRequest $request): int|ExternallyDeliveredOrderEntity
    {
        // 1 Update order status in ExternallyDeliveredOrderEntity
        $externallyDeliveredOrder = $this->updateExternallyDeliveredOrderStatus($request);

        if ($externallyDeliveredOrder === ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST) {
            return ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST;
        }

        // 2 Get order status
        $newOrderStatus = $this->getOrderStatusFromExternalOne($request->getStatus(), $externallyDeliveredOrder->getOrderId());

        // 2 Update order status in OrderEntity
        $order = $this->updateOrderStateByOrderEntityAndNewState($externallyDeliveredOrder->getOrderId(), $newOrderStatus);

        // 3 Return appropriate result
        return $externallyDeliveredOrder;
    }
}
