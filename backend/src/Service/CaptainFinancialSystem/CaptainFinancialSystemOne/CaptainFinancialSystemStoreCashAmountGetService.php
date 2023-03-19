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

    /**
     * Get the sum of unpaid cash and delivered orders amount (for store) by specific captain and among specific date
     */
    public function getUnPaidCashOrdersDuesByCaptainProfileIdAndDuringSpecificTime(int $captainProfileId, string $fromDate, string $toDate): string
    {
        return $this->storeOwnerDuesFromCashOrdersService->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainProfileId,
            $fromDate, $toDate);
    }
}
