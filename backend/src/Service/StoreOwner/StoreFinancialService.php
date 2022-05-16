<?php

namespace App\Service\StoreOwner;

use App\Manager\StoreOwner\StoreFinancialManager;

class StoreFinancialService
{
    private StoreFinancialManager $storeFinancialManager;

    public function __construct(StoreFinancialManager $storeFinancialManager)
    {
        $this->storeFinancialManager = $storeFinancialManager;
    }

    // Get store profit margin (either private or common one)
    public function getStoreProfitMarginForStoreOwner(int $userId): float
    {
        return $this->storeFinancialManager->getStoreProfitMarginForStoreOwner($userId);
    }
}
