<?php

namespace App\Service\ExternallyDeliveredOrder;

use App\Constant\ExternallyDeliveredOrder\ExternallyDeliveredOrderConstant;
use App\Entity\ExternallyDeliveredOrderEntity;
use App\Manager\ExternallyDeliveredOrder\ExternallyDeliveredOrderManager;

/**
 * Responsible for fetching objects of ExternallyDeliveredOrderEntity
 */
class ExternallyDeliveredOrderGetService
{
    public function __construct(
        private ExternallyDeliveredOrderManager $externallyDeliveredOrderManager
    )
    {
    }

    public function getAllExternallyDeliveredOrdersByOrderId(int $orderId): array
    {
        return $this->externallyDeliveredOrderManager->getAllExternallyDeliveredOrdersByOrderId($orderId);
    }

    public function getExternallyDeliveredOrdersByStatus(string $status): array
    {
        return $this->externallyDeliveredOrderManager->getExternallyDeliveredOrdersByStatus($status);
    }

    public function getOnGoingExternallyDeliveredOrders(): array
    {
        return $this->externallyDeliveredOrderManager->getOnGoingExternallyDeliveredOrders();
    }

    public function getExternallyDeliveredOrderByExternalOrderId(int $externalOrderId): ?ExternallyDeliveredOrderEntity
    {
        return $this->externallyDeliveredOrderManager->getExternallyDeliveredOrderByExternalOrderId($externalOrderId);
    }

    public function getLastExternallyDeliveredOrderByOrderId(int $orderId): ExternallyDeliveredOrderEntity|int
    {
        $externallyDeliveredOrder = $this->externallyDeliveredOrderManager->getLastExternallyDeliveredOrderByOrderId($orderId);

        if (count($externallyDeliveredOrder) > 0) {
            return $externallyDeliveredOrder[0];
        }

        return ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST;
    }
}
