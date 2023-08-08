<?php

namespace App\Service\StreetLine;

use App\AutoMapping;
use App\Constant\ExternallyDeliveredOrder\ExternallyDeliveredOrderConstant;
use App\Constant\OrderLog\OrderLogActionTypeConstant;
use App\Constant\OrderLog\OrderLogCreatedByUserTypeConstant;
use App\Entity\ExternallyDeliveredOrderEntity;
use App\Entity\OrderEntity;
use App\Request\StreetLine\StreetLineOrderStatusUpdateRequest;
use App\Response\StreetLine\StreetLineOrderStatusUpdateResponse;
use App\Service\ExternalOrderUpdateHandler\ExternalOrderUpdateHandlerService;
use App\Service\OrderLog\OrderLogService;

class StreetLineOrderService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private ExternalOrderUpdateHandlerService $externalOrderUpdateHandlerService,
        private OrderLogService $orderLogService
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
        $this->orderLogService->createOrderLogMessage($orderEntity, 1, OrderLogCreatedByUserTypeConstant::STREETLINE_EXTERNAL_DELIVERY_COMPANY_CONST,
            OrderLogActionTypeConstant::ORDER_STATUS_UPDATE_BY_STREETLINE_EXTERNAL_COMPANY_CONST, $details,
            null, null);
    }
}
