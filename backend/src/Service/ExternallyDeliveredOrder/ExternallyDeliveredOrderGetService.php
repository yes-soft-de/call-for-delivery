<?php

namespace App\Service\ExternallyDeliveredOrder;

use App\Manager\ExternallyDeliveredOrder\ExternallyDeliveredOrderManager;

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
}
