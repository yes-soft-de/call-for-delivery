<?php

namespace App\Service\StoreOwnerDuesFromCashOrders;

use App\Manager\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersManager;

class StoreOwnerDueFromCashOrderGetService
{
    public function __construct(
        private StoreOwnerDuesFromCashOrdersManager $storeOwnerDuesFromCashOrdersManager
    )
    {
    }

    /**
     * Get the sum of the unpaid cash orders to store
     */
    public function getUnPaidStoreOwnerDuesFromCashOrderSumByStoreSubscriptionId(int $subscriptionId): float
    {
        $unPaidCashOrdersSum = $this->storeOwnerDuesFromCashOrdersManager->getUnPaidStoreOwnerDuesFromCashOrderSumByStoreSubscriptionId($subscriptionId);

        if (count($unPaidCashOrdersSum) > 0) {
            return $unPaidCashOrdersSum[0];
        }

        return 0.0;
    }
}
