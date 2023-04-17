<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDaily;

use App\Service\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialSystemTwo\CaptainFinancialSystemTwoDailyGetBalanceDetailsService;

class CaptainFinancialSystemTwoDailyService
{
    public function __construct(
        private CaptainFinancialSystemTwoDailyGetBalanceDetailsService $captainFinancialSystemTwoDailyGetBalanceDetailsService
    )
    {
    }

    /**
     * Get array which includes:
     * basic captain financial amount (due), bonus, and amount for store
     */
    public function getDailyCaptainFinancialAmount(array $captainFinancialSystemDetail, int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemTwoDailyGetBalanceDetailsService->calculateCaptainDuesAndStoreCashAmountOnly($captainFinancialSystemDetail,
            $captainProfileId, $fromDate, $toDate);
    }
}
