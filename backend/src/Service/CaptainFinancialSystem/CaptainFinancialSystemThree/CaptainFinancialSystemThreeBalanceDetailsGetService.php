<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemThree;

use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemThreeBalanceDetailManager;

class CaptainFinancialSystemThreeBalanceDetailsGetService
{
    private CaptainFinancialSystemThreeBalanceDetailManager $captainFinancialSystemThreeBalanceDetailManager;

    public function __construct(CaptainFinancialSystemThreeBalanceDetailManager $captainFinancialSystemThreeBalanceDetailManager)
    {
        $this->captainFinancialSystemThreeBalanceDetailManager = $captainFinancialSystemThreeBalanceDetailManager;
    }

    public function getCountOrdersByFinancialSystemThree(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): ?array
    {
        return $this->captainFinancialSystemThreeBalanceDetailManager->getCountOrdersByFinancialSystemThree($captainId, $fromDate, $toDate, $countKilometersFrom,
            $countKilometersTo);
    }
}
