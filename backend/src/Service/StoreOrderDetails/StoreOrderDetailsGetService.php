<?php

namespace App\Service\StoreOrderDetails;

use App\Manager\Order\StoreOrderDetailsManager;

class StoreOrderDetailsGetService
{
    public function __construct(
        private StoreOrderDetailsManager $storeOrderDetailsManager
    )
    {
    }

    public function getNormalOrderDestinationByOrderId(int $orderId): array|int
    {
        return $this->storeOrderDetailsManager->getNormalOrderDestinationByOrderId($orderId);
    }
}
