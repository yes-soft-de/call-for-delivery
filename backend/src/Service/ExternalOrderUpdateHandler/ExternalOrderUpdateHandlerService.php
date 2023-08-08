<?php

namespace App\Service\ExternalOrderUpdateHandler;

use App\AutoMapping;
use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyIdentityConstant;
use App\Constant\ExternalDeliveryCompany\Mrsool\MrsoolCompanyConstant;
use App\Constant\ExternalDeliveryCompany\StreetLine\StreetLineCompanyConstant;
use App\Constant\ExternallyDeliveredOrder\ExternallyDeliveredOrderConstant;
use App\Constant\Order\OrderStateConstant;
use App\Entity\ExternallyDeliveredOrderEntity;
use App\Entity\OrderEntity;
use App\Request\ExternallyDeliveredOrder\ExternallyDeliveredOrderStatusUpdateRequest;
use App\Request\Mrsool\MrsoolOrderStatusUpdateRequest;
use App\Request\StreetLine\StreetLineOrderStatusUpdateRequest;
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

    /**
     * Gets Externally Delivered Order By External Order Id And External Company Id
     */
    public function getExternallyDeliveredOrderByExternalOrderId(int $externalOrderId, int $externalCompanyId): ?ExternallyDeliveredOrderEntity
    {
        return $this->externallyDeliveredOrderGetService->getExternallyDeliveredOrderByExternalOrderId($externalOrderId, $externalCompanyId);
    }

    public function updateExternallyDeliveredOrderStatus(MrsoolOrderStatusUpdateRequest $request): ExternallyDeliveredOrderEntity|int
    {
        // get externally delivered order id
        $externallyDeliveredOrder = $this->getExternallyDeliveredOrderByExternalOrderId($request->getId(),
            ExternalDeliveryCompanyIdentityConstant::MRSOOL_COMPANY_CONST);

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

    public function updateStreetLineExternallyDeliveredOrderStatus(StreetLineOrderStatusUpdateRequest $request): ExternallyDeliveredOrderEntity|int
    {
        // get externally delivered order id
        $externallyDeliveredOrder = $this->getExternallyDeliveredOrderByExternalOrderId($request->getOrderId(),
            ExternalDeliveryCompanyIdentityConstant::STREET_LINE_COMPANY_CONST);

        if (! $externallyDeliveredOrder) {
            return ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST;
        }

        $externallyDeliveredOrderStatusUpdateRequest = $this->autoMapping->map(StreetLineOrderStatusUpdateRequest::class,
            ExternallyDeliveredOrderStatusUpdateRequest::class, $request);

        $externallyDeliveredOrderStatusUpdateRequest->setId($externallyDeliveredOrder->getId());

        return $this->externallyDeliveredOrderService->updateExternallyDeliveredOrderStatus($externallyDeliveredOrderStatusUpdateRequest);
    }

    public function getOrderStatusFromExternalOneAtStreetLine(string $externalOrderStatus, string $internalOrderStatus): string
    {
        // 1 compare status
        if (($externalOrderStatus === StreetLineCompanyConstant::ORDER_CREATED_STATUS_CONST)
            || ($externalOrderStatus === StreetLineCompanyConstant::PENDING_ORDER_PREPARATION_STATUS_CONST)) {
            $internalOrderStatus = OrderStateConstant::ORDER_STATE_PENDING;

        } elseif ($externalOrderStatus === StreetLineCompanyConstant::ARRIVED_TO_PICKUP_STATUS_CONST) {
            $internalOrderStatus = OrderStateConstant::ORDER_STATE_IN_STORE;

        } elseif (($externalOrderStatus === StreetLineCompanyConstant::ORDER_PICKED_UP_STATUS_CONST)
            || ($externalOrderStatus === StreetLineCompanyConstant::ARRIVED_TO_DROP_OFF_STATUS_CONST)) {
            $internalOrderStatus = OrderStateConstant::ORDER_STATE_ONGOING;

        } elseif ($externalOrderStatus === StreetLineCompanyConstant::ORDER_DELIVERED_STATUS_CONST) {
            $internalOrderStatus = OrderStateConstant::ORDER_STATE_DELIVERED;

        } elseif (($externalOrderStatus === StreetLineCompanyConstant::ORDER_CANCELLED_STATUS_CONST)
            || ($externalOrderStatus === StreetLineCompanyConstant::ORDER_FAILED_STATUS_CONST)) {
            $internalOrderStatus = OrderStateConstant::ORDER_STATE_CANCEL;
        }

        return $internalOrderStatus;
    }

    public function handleStreetLineOrderStatusUpdate(StreetLineOrderStatusUpdateRequest $request): int|ExternallyDeliveredOrderEntity
    {
        // 1 Update order status in ExternallyDeliveredOrderEntity
        $externallyDeliveredOrder = $this->updateStreetLineExternallyDeliveredOrderStatus($request);

        if ($externallyDeliveredOrder === ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST) {
            return ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST;
        }

        // 2 Get order status
        $newOrderStatus = $this->getOrderStatusFromExternalOneAtStreetLine($request->getStatus(),
            $externallyDeliveredOrder->getOrderId()->getState());//dd($newOrderStatus);

        // 2 Update order status in OrderEntity
        $order = $this->updateOrderStateByOrderEntityAndNewState($externallyDeliveredOrder->getOrderId(), $newOrderStatus);

        // 3 Return appropriate result
        return $externallyDeliveredOrder;
    }
}
