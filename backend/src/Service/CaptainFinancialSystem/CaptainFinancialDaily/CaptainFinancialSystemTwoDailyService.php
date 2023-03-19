<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDaily;

use App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwo\CaptainFinancialSystemTwoGetBalanceDetailsService;

class CaptainFinancialSystemTwoDailyService
{
    public function __construct(
        private CaptainFinancialSystemTwoGetBalanceDetailsService $captainFinancialSystemTwoGetBalanceDetailsService
    )
    {
    }

    /**
     * Get array which includes:
     * basic captain financial amount (due), bonus, and amount for store
     */
    public function getDailyCaptainFinancialAmount(array $captainFinancialSystemDetail, int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemTwoGetBalanceDetailsService->calculateCaptainDuesAndStoreCashAmountOnly($captainFinancialSystemDetail,
            $captainProfileId, $fromDate, $toDate);
    }
}
