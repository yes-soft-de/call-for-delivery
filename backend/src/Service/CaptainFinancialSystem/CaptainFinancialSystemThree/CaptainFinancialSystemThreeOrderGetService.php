<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemThree;

use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemThreeOrderManager;

class CaptainFinancialSystemThreeOrderGetService
{
    public function __construct(
        private CaptainFinancialSystemThreeOrderManager $captainFinancialSystemThreeOrderManager)
    {
    }

    public function getCountOrdersByFinancialSystemThree(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): ?array
    {
        return $this->captainFinancialSystemThreeOrderManager->getCountOrdersByFinancialSystemThree($captainId, $fromDate, $toDate, $countKilometersFrom,
            $countKilometersTo);
    }

    public function getDetailOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate)
    {
        return $this->captainFinancialSystemThreeOrderManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    /**
     * Get count of orders without distance and delivered by specific captain during specific time
     */
    public function getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): int
    {
        $ordersCountResult = $this->captainFinancialSystemThreeOrderManager->getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);

        if (count($ordersCountResult) > 0) {
            return $ordersCountResult[0];
        }

        return 0;
    }
}
