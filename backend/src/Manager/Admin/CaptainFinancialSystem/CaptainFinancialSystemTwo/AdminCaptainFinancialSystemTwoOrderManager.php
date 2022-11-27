<?php

namespace App\Manager\Admin\CaptainFinancialSystem\CaptainFinancialSystemTwo;

use App\Repository\OrderEntityRepository;

class AdminCaptainFinancialSystemTwoOrderManager
{
    private OrderEntityRepository $orderEntityRepository;

    public function __construct(OrderEntityRepository $orderEntityRepository)
    {
        $this->orderEntityRepository = $orderEntityRepository;
    }

    public function getDeliveredOrdersCountByCaptainIdAndBetweenTwoDatesForAdmin(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getDeliveredOrdersByCountCaptainIdAndBetweenTwoDates($captainId, $fromDate, $toDate);
    }

    public function getDetailOrdersByCaptainIdOnSpecificDateForAdmin(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    public function getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDatesForAdmin(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates($captainId, $fromDate, $toDate);
    }
}
