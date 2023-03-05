<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemOne;

use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemOne\CaptainFinancialSystemOneOrderManager;

class CaptainFinancialSystemOneOrderGetService
{
    public function __construct(
        private CaptainFinancialSystemOneOrderManager $captainFinancialSystemOneOrderManager
    )
    {
    }

    public function getDeliveredOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemOneOrderManager->getDeliveredOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);
    }

    public function getOverdueDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemOneOrderManager->getOverdueDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainId, $fromDate, $toDate);
    }

    // Get count of orders without distance and delivered by specific captain during specific time
    public function getOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemOneOrderManager->getDeliveredOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);
    }
}
