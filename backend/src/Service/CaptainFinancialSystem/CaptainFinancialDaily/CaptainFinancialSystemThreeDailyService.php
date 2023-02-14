<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDaily;

use App\Service\CaptainFinancialSystem\CaptainFinancialSystemThree\CaptainFinancialSystemThreeGetBalanceDetailsService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemThree\CaptainFinancialSystemThreeGetService;

class CaptainFinancialSystemThreeDailyService
{
    public function __construct(
        private CaptainFinancialSystemThreeGetService $captainFinancialSystemThreeGetService,
        private CaptainFinancialSystemThreeGetBalanceDetailsService $captainFinancialSystemThreeGetBalanceDetailsService
    )
    {
    }

    public function getAllCaptainFinancialSystemThreePlansAsArray(): array
    {
        return $this->captainFinancialSystemThreeGetService->getAllCaptainFinancialSystemThreePlansAsArray();
    }

    public function getDailyCaptainFinancialAmount(int $captainProfileId, string $fromDate, string $toDate): array
    {
        $financialSystemThreeDetails = $this->getAllCaptainFinancialSystemThreePlansAsArray();

        if (count($financialSystemThreeDetails) === 0) {
            return [0.0, 0.0, 0.0];
        }

        return $this->captainFinancialSystemThreeGetBalanceDetailsService->calculateCaptainDuesAndStoreCashAmountOnly($financialSystemThreeDetails,
            $captainProfileId, $fromDate, $toDate);
    }
}
