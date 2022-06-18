<?php

namespace App\Service\Order;

use App\Entity\StoreOwnerBranchEntity;
use App\Manager\Order\StoreOrderDetailsManager;

class StoreOrderDetailsService
{
    private StoreOrderDetailsManager $storeOrderDetailsManager;

    public function __construct(StoreOrderDetailsManager $storeOrderDetailsManager)
    {
        $this->storeOrderDetailsManager = $storeOrderDetailsManager;
    }

    public function getStoreBranchByOrderId(int $orderId): ?StoreOwnerBranchEntity
    {
        $storeOrderDetails = $this->storeOrderDetailsManager->getOrderDetailsByOrderId($orderId);

        if ($storeOrderDetails !== null) {
            return $storeOrderDetails->getBranch();
        }

        return $storeOrderDetails;
    }
}
