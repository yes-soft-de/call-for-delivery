<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwo;

use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemTwo\CaptainFinancialSystemTwoOrderManager;

class CaptainFinancialSystemTwoGetService
{
    private CaptainFinancialSystemTwoOrderManager $captainFinancialSystemTwoOrderManager;

    public function __construct(CaptainFinancialSystemTwoOrderManager $captainFinancialSystemTwoOrderManager)
    {
        $this->captainFinancialSystemTwoOrderManager = $captainFinancialSystemTwoOrderManager;
    }

    public function getDeliveredOrdersCountByCaptainIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemTwoOrderManager->getDeliveredOrdersCountByCaptainIdAndBetweenTwoDates($captainId, $fromDate, $toDate);
    }

    public function getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemTwoOrderManager->getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates($captainId, $fromDate, $toDate);
    }
}
