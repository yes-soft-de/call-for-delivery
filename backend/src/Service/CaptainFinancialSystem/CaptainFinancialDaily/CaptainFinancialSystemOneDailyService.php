<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDaily;

use App\Service\CaptainFinancialSystem\CaptainFinancialSystemOne\CaptainFinancialSystemOneGetBalanceDetailsService;

class CaptainFinancialSystemOneDailyService
{
    public function __construct(
        private CaptainFinancialSystemOneGetBalanceDetailsService $captainFinancialSystemOneGetBalanceDetailsService
    )
    {
    }

    /**
     * Get array which includes:
     * basic captain financial amount (due), bonus, and amount for store
     */
    public function getDailyCaptainFinancialAmount(array $captainFinancialSystemDetail, int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemOneGetBalanceDetailsService->calculateCaptainDuesAndStoreCashAmountOnly($captainFinancialSystemDetail,
            $captainProfileId, $fromDate, $toDate);
    }
}
