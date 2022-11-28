<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwo;

use App\Service\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersService;

class CaptainFinancialSystemTwoGetStoreAmountService
{
    private StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService;

    public function __construct(StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService)
    {
        $this->storeOwnerDuesFromCashOrdersService = $storeOwnerDuesFromCashOrdersService;
    }

    // Get the dues of unpaid cash orders (for group of orders)
    public function getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime(int $captainId, string $fromDate, string $toDate): array
    {
        $result = $this->storeOwnerDuesFromCashOrdersService->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainId, $fromDate, $toDate);

        return $result;
    }
}
