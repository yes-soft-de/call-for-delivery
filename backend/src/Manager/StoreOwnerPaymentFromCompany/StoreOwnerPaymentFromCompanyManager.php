<?php

namespace App\Manager\StoreOwnerPaymentFromCompany;

use App\Repository\StoreOwnerPaymentFromCompanyEntityRepository;

class StoreOwnerPaymentFromCompanyManager
{
    private StoreOwnerPaymentFromCompanyEntityRepository $storeOwnerPaymentFromCompanyEntityRepository;

    public function __construct(StoreOwnerPaymentFromCompanyEntityRepository $storeOwnerPaymentFromCompanyEntityRepository)
    {
        $this->storeOwnerPaymentFromCompanyEntityRepository = $storeOwnerPaymentFromCompanyEntityRepository;
    }

    public function getPaymentsFromCompanyByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->storeOwnerPaymentFromCompanyEntityRepository->getPaymentsFromCompanyByStoreOwnerId($storeOwnerId);
    }
}
