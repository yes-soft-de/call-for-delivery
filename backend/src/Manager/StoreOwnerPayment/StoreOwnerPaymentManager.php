<?php

namespace App\Manager\StoreOwnerPayment;

use App\Repository\StoreOwnerPaymentEntityRepository;

class StoreOwnerPaymentManager
{
    private StoreOwnerPaymentEntityRepository $storeOwnerPaymentEntityRepository;

    public function __construct(StoreOwnerPaymentEntityRepository $storeOwnerPaymentEntityRepository)
    {
        $this->storeOwnerPaymentEntityRepository = $storeOwnerPaymentEntityRepository;
    }

    public function getStorePaymentsBySubscriptionId(int $subscriptionId): ?array
    {
        return $this->storeOwnerPaymentEntityRepository->getStorePaymentsBySubscriptionId($subscriptionId);
    }

    public function getPaymentsByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->storeOwnerPaymentEntityRepository->getPaymentsByStoreOwnerId($storeOwnerId);
    }
}
