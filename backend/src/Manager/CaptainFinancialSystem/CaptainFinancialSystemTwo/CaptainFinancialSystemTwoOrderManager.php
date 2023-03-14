<?php

namespace App\Manager\CaptainFinancialSystem\CaptainFinancialSystemTwo;

use App\Repository\OrderEntityRepository;

class CaptainFinancialSystemTwoOrderManager
{
    public function __construct(
        private OrderEntityRepository $orderEntityRepository
    )
    {
    }

    public function getDeliveredOrdersCountByCaptainIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getDeliveredOrdersByCountCaptainIdAndBetweenTwoDates($captainId, $fromDate,
            $toDate);
    }

    public function getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates($captainId, $fromDate,
            $toDate);
    }

    /**
     * Get count of orders without distance and delivered by specific captain during specific time
     */
    public function getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate($captainId, $fromDate,
            $toDate);
    }

    public function getOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    public function getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);
    }

    public function getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
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
