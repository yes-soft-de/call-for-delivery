<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDaily;

use App\Service\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialSystemThree\CaptainFinancialSystemThreeDailyGetBalanceDetailsService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemThree\CaptainFinancialSystemThreeGetService;

class CaptainFinancialSystemThreeDailyService
{
    public function __construct(
        private CaptainFinancialSystemThreeGetService $captainFinancialSystemThreeGetService,
        private CaptainFinancialSystemThreeDailyGetBalanceDetailsService $captainFinancialSystemThreeDailyGetBalanceDetailsService
    )
    {
    }

    /**
     * Gets all sub-plans of the third financial system
     */
    public function getAllCaptainFinancialSystemThreePlansAsArray(): array
    {
        return $this->captainFinancialSystemThreeGetService->getAllCaptainFinancialSystemThreePlansAsArray();
    }

    /**
     * Gets an array which include:
     * the basic financial amount of today
     * the bonus (according to the current financial cycle) (if exists)
     * and the cash amount for the store
     */
    public function getDailyCaptainFinancialAmount(int $captainProfileId, string $fromDate, string $toDate): array
    {
        $financialSystemThreeDetails = $this->getAllCaptainFinancialSystemThreePlansAsArray();

        if (count($financialSystemThreeDetails) === 0) {
            $response = [];

            $response['basicFinancialAmount'] = 0.0;
            $response['bounce'] = 0.0;
            $response['amountForStore'] = 0.0;

            return $response;
        }

        return $this->captainFinancialSystemThreeDailyGetBalanceDetailsService->calculateCaptainDuesAndStoreCashAmountOnly($financialSystemThreeDetails,
            $captainProfileId, $fromDate, $toDate);
    }
}
