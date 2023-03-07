<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwo;

use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemTwo\CaptainFinancialSystemTwoOrderManager;

class CaptainFinancialSystemTwoOrderGetService
{
    public function __construct(
        private CaptainFinancialSystemTwoOrderManager $captainFinancialSystemTwoOrderManager
    )
    {
    }

    public function getDeliveredOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemTwoOrderManager->getDeliveredOrdersCountByCaptainIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);
    }

    public function getOverdueDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemTwoOrderManager->getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);
    }

    // Get count of orders without distance and delivered by specific captain during specific time
    public function getOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemTwoOrderManager->getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);
    }

    public function getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemTwoOrderManager->getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);
    }

    public function getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemTwoOrderManager->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);
    }

    /**
     * Get count of orders without distance and cancelled by store and related to specific captain during specific time
     */
    public function getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemTwoOrderManager->getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);
    }
}
