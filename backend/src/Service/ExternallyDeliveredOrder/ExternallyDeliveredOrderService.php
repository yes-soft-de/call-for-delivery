<?php

namespace App\Service\ExternallyDeliveredOrder;

use App\Entity\ExternallyDeliveredOrderEntity;
use App\Manager\ExternallyDeliveredOrder\ExternallyDeliveredOrderManager;
use App\Request\ExternallyDeliveredOrder\ExternallyDeliveredOrderCreateRequest;

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
}
