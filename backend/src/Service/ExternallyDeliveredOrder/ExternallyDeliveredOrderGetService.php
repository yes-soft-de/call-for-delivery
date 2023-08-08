<?php

namespace App\Service\ExternallyDeliveredOrder;

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

//    public function getExternallyDeliveredOrdersByStatus(string $status): array
//    {
//        return $this->externallyDeliveredOrderManager->getExternallyDeliveredOrdersByStatus($status);
//    }

//    public function getOnGoingExternallyDeliveredOrders(): array
//    {
//        return $this->externallyDeliveredOrderManager->getOnGoingExternallyDeliveredOrders();
//    }

    /**
     *
     * Gets Externally Delivered Order By External Order Id And External Company Id
     */
    public function getExternallyDeliveredOrderByExternalOrderId(int $externalOrderId, int $externalCompanyId): ?ExternallyDeliveredOrderEntity
    {
        return $this->externallyDeliveredOrderManager->getExternallyDeliveredOrderByExternalOrderIdAndExternalCompanyId($externalOrderId,
            $externalCompanyId);
    }
}
