<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemOne;

use App\Service\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersService;

class CaptainFinancialSystemStoreCashAmountGetService
{
    public function __construct(
        private StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService
    )
    {
    }

    // Get the dues of unpaid cash orders (for group of orders)
    public function getUnPaidCashOrdersDuesByCaptainProfileIdAndDuringSpecificTime(int $captainProfileId, string $fromDate, string $toDate): string
    {
        return $this->storeOwnerDuesFromCashOrdersService->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainProfileId,
            $fromDate, $toDate);
    }
}
