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
        return $this->captainFinancialSystemOneOrderManager->getOverdueDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainId,
            $fromDate, $toDate);
    }

    // Get count of orders without distance and delivered by specific captain during specific time
    public function getOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemOneOrderManager->getOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);
    }

    public function getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemOneOrderManager->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);
    }

    public function getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemOneOrderManager->getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates($captainId,
            $fromDate, $toDate);
    }

    /**
     * Get count of orders without distance and cancelled by store and related to specific captain during specific time
     */
    public function getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemOneOrderManager->getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);
    }
}
