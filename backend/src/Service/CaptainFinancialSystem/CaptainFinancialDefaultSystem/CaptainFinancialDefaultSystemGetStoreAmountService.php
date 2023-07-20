<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDefaultSystem;

use App\Entity\StoreOwnerDuesFromCashOrdersEntity;
use App\Service\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersService;

class CaptainFinancialDefaultSystemGetStoreAmountService
{
    public function __construct(
        private StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService
    )
    {
    }

    // Get the dues of unpaid cash orders (for group of orders)
    public function getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime(int $captainId, string $fromDate, string $toDate): string
    {
        return $this->storeOwnerDuesFromCashOrdersService->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainId, $fromDate, $toDate);
    }

    public function getUnPaidStoreOwnerDuesFromCashOrdersByOrderId(int $orderId): int|StoreOwnerDuesFromCashOrdersEntity
    {
        return $this->storeOwnerDuesFromCashOrdersService->getUnPaidStoreOwnerDuesFromCashOrdersByOrderId($orderId);
    }
}
