<?php

namespace App\Service\Mrsool;

use App\AutoMapping;
use App\Constant\ExternallyDeliveredOrder\ExternallyDeliveredOrderConstant;
use App\Constant\OrderLog\OrderLogActionTypeConstant;
use App\Constant\OrderLog\OrderLogCreatedByUserTypeConstant;
use App\Entity\ExternallyDeliveredOrderEntity;
use App\Entity\OrderEntity;
use App\Request\Mrsool\MrsoolOrderStatusUpdateRequest;
use App\Response\Mrsool\MrsoolOrderStatusUpdateResponse;
use App\Service\ExternalOrderUpdateHandler\ExternalOrderUpdateHandlerService;
use App\Service\OrderLog\OrderLogService;

class MrsoolOrderService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private ExternalOrderUpdateHandlerService $externalOrderUpdateHandlerService,
        private OrderLogService $orderLogService
    )
    {
    }

    public function updateMrsoolOrderStatus(MrsoolOrderStatusUpdateRequest $request): int|MrsoolOrderStatusUpdateResponse
    {
        $order = $this->externalOrderUpdateHandlerService->handleMrsoolOrderStatusUpdate($request);

        if ($order === ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST) {
            return ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST;
        }

        // save order log
        $this->createOrderLogMessageViaOrderEntityAndByMarsoolCompany($order->getOrderId(), [
            'externalCompanyName' => $order->getExternalDeliveryCompany()->getCompanyName()
        ]);

        return $this->autoMapping->map(ExternallyDeliveredOrderEntity::class, MrsoolOrderStatusUpdateResponse::class,
            $order);
    }

    public function createOrderLogMessageViaOrderEntityAndByMarsoolCompany(OrderEntity $orderEntity, array $details)
    {
        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($orderEntity, 1, OrderLogCreatedByUserTypeConstant::MARSOOL_EXTERNAL_DELIVERY_COMPANY_CONST,
            OrderLogActionTypeConstant::ORDER_STATUS_UPDATE_BY_MARSOOL_EXTERNAL_COMPANY_CONST, $details,
            null, null);
    }
}
