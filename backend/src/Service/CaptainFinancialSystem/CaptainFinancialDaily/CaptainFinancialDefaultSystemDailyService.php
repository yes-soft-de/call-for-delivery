<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDaily;

use App\Service\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDefaultSystem\CaptainFinancialDefaultSystemDailyGetBalanceDetailsService;

/**
 * Responsible for handling Captain Financial Default System Calls from Captain Financial Daily
 */
class CaptainFinancialDefaultSystemDailyService
{
    public function __construct(
        private CaptainFinancialDefaultSystemDailyGetBalanceDetailsService $captainFinancialDefaultSystemDailyGetBalanceDetailsService
    )
    {
    }

    public function getDailyCaptainFinancialAmount(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialDefaultSystemDailyGetBalanceDetailsService->calculateCaptainDuesAndStoreCashAmountOnly($captainFinancialSystemDetail,
            $captainProfileId, $fromDate, $toDate);
    }
}
