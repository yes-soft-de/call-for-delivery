<?php

namespace App\Service\Admin\CaptainFinancialSystem\CaptainFinancialSystemOne;

use App\Service\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersService;

class AdminCaptainFinancialSystemOneGetStoreAmountService
{
    public function __construct(
        private StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService
    )
    {
    }

    /**
     * Get the dues of unpaid cash orders (for group of orders)
     */
    public function getUnPaidCashOrdersDuesByCaptainProfileIdAndDuringSpecificDateForAdmin(int $captainProfileId, string $fromDate, string $toDate): string
    {
        return $this->storeOwnerDuesFromCashOrdersService->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainProfileId,
            $fromDate, $toDate);
    }
}
