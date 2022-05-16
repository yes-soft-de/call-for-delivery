<?php

namespace App\Manager\StoreOwner;

use App\Manager\CompanyInfo\CompanyInfoManager;

class StoreFinancialManager
{
    private StoreOwnerProfileManager $storeOwnerProfileManager;
    private CompanyInfoManager $companyInfoManager;

    public function __construct(StoreOwnerProfileManager $storeOwnerProfileManager, CompanyInfoManager $companyInfoManager)
    {
        $this->storeOwnerProfileManager = $storeOwnerProfileManager;
        $this->companyInfoManager = $companyInfoManager;
    }

    // Get store profit margin (either private or common one)
    public function getStoreProfitMarginForStoreOwner(int $userId): float
    {
        $storeProfitMargin = $this->storeOwnerProfileManager->getStoreProfitMarginByStoreOwnerId($userId);

        if (! $storeProfitMargin['profitMargin']) {
            // There is no private profit margin for the store, so we have to get the common profit margin
            $storeProfitMargin = $this->companyInfoManager->getStoreProfitMargin();

            if (! $storeProfitMargin['storeProfitMargin']) {
                return 0.0;
            }

            return round($storeProfitMargin['storeProfitMargin'], 2);
        }

        return round($storeProfitMargin['profitMargin'], 2);
    }
}
