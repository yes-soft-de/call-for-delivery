<?php

namespace App\Service\StoreOwnerPaymentFromCompany;

use App\Manager\StoreOwnerPaymentFromCompany\StoreOwnerPaymentFromCompanyManager;

class StoreOwnerPaymentFromCompanyService
{
    private StoreOwnerPaymentFromCompanyManager $storeOwnerPaymentFromCompanyManager;

    public function __construct(StoreOwnerPaymentFromCompanyManager $storeOwnerPaymentFromCompanyManager)
    {
        $this->storeOwnerPaymentFromCompanyManager = $storeOwnerPaymentFromCompanyManager;
    }

    public function getPaymentsFromCompanyByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->storeOwnerPaymentFromCompanyManager->getPaymentsFromCompanyByStoreOwnerId($storeOwnerId);
    }
}
