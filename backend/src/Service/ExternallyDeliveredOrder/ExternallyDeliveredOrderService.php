<?php

namespace App\Service\ExternallyDeliveredOrder;

use App\Constant\ExternallyDeliveredOrder\ExternallyDeliveredOrderConstant;
use App\Entity\ExternallyDeliveredOrderEntity;
use App\Manager\ExternallyDeliveredOrder\ExternallyDeliveredOrderManager;
use App\Request\ExternallyDeliveredOrder\ExternallyDeliveredOrderCreateRequest;
use App\Request\ExternallyDeliveredOrder\ExternallyDeliveredOrderStatusUpdateRequest;

/**
 * Responsible for create/update objects of ExternallyDeliveredOrderEntity
 */
class ExternallyDeliveredOrderService
{
    public function __construct(
        private ExternallyDeliveredOrderManager $externallyDeliveredOrderManager
    )
    {
    }

    public function createExternallyDeliveredOrder(ExternallyDeliveredOrderCreateRequest $request): ExternallyDeliveredOrderEntity
    {
        return $this->externallyDeliveredOrderManager->createExternallyDeliveredOrder($request);
    }

    public function updateExternallyDeliveredOrderStatus(ExternallyDeliveredOrderStatusUpdateRequest $request): int|ExternallyDeliveredOrderEntity
    {
        $externallyDeliveredOrderEntity = $this->externallyDeliveredOrderManager->updateExternallyDeliveredOrderStatus($request);

        if (! $externallyDeliveredOrderEntity) {
            return ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST;
        }

        return $externallyDeliveredOrderEntity;
    }
}
