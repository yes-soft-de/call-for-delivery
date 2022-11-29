<?php

namespace App\Manager\CaptainFinancialSystem\CaptainFinancialSystemTwo;

use App\Repository\OrderEntityRepository;

class CaptainFinancialSystemTwoOrderManager
{
    private OrderEntityRepository $orderEntityRepository;

    public function __construct(OrderEntityRepository $orderEntityRepository)
    {
        $this->orderEntityRepository = $orderEntityRepository;
    }

    public function getDeliveredOrdersCountByCaptainIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getDeliveredOrdersByCountCaptainIdAndBetweenTwoDates($captainId, $fromDate, $toDate);
    }

    public function getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates($captainId, $fromDate, $toDate);
    }

    // Get count of orders without distance and delivered by specific captain during specific time
    public function getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    public function getOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }
}
