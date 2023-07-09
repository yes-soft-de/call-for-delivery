<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDaily;

use App\Service\CaptainFinancialSystem\CaptainFinancialDefaultSystem\CaptainFinancialDefaultSystemGetBalanceService;

/**
 * Responsible for handling Captain Financial Default System Calls from Captain Financial Daily
 */
class CaptainFinancialDefaultSystemDailyService
{
    public function __construct(
        private CaptainFinancialDefaultSystemGetBalanceService $captainFinancialDefaultSystemGetBalanceService
    )
    {
    }

    public function getDailyCaptainFinancialAmount(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialDefaultSystemGetBalanceService->calculateCaptainDuesAndStoreCashAmountOnly($captainFinancialSystemDetail,
            $captainProfileId, $fromDate, $toDate);
    }
}
