<?php

namespace App\Manager\CaptainFinancialSystem\CaptainFinancialSystemOne;

use App\Manager\Order\OrderManager;
use App\Repository\OrderEntityRepository;

class CaptainFinancialSystemOneOrderManager
{
    public function __construct(
        private OrderEntityRepository $orderEntityRepository
    )
    {
    }

    public function getDeliveredOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getDeliveredOrdersByCountCaptainIdAndBetweenTwoDates($captainId,
            $fromDate, $toDate);
    }

    public function getOverdueDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates($captainId,
            $fromDate, $toDate);
    }

    // Get count of orders without distance and delivered by specific captain during specific time
    public function getOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);
    }

    public function getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainId,
            $fromDate, $toDate);
    }

    public function getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates($captainId,
            $fromDate, $toDate);
    }

    /**
     * Get count of orders without distance and cancelled by store and related to specific captain during specific time
     */
    public function getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);
    }
}
