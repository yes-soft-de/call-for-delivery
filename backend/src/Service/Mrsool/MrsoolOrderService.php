<?php

namespace App\Service\Mrsool;

use App\AutoMapping;
use App\Constant\ExternallyDeliveredOrder\ExternallyDeliveredOrderConstant;
use App\Entity\ExternallyDeliveredOrderEntity;
use App\Request\Mrsool\MrsoolOrderStatusUpdateRequest;
use App\Response\Mrsool\MrsoolOrderStatusUpdateResponse;
use App\Service\ExternalOrderUpdateHandler\ExternalOrderUpdateHandlerService;

class MrsoolOrderService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private ExternalOrderUpdateHandlerService $externalOrderUpdateHandlerService
    )
    {
    }

    public function updateMrsoolOrderStatus(MrsoolOrderStatusUpdateRequest $request): int|MrsoolOrderStatusUpdateResponse
    {
        $order = $this->externalOrderUpdateHandlerService->handleMrsoolOrderStatusUpdate($request);

        if ($order === ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST) {
            return ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST;
        }

        return $this->autoMapping->map(ExternallyDeliveredOrderEntity::class, MrsoolOrderStatusUpdateResponse::class,
            $order);
    }
}
