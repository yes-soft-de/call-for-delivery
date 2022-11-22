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

    public function getDetailOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    public function getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates($captainId, $fromDate, $toDate);
    }
}
