<?php

namespace App\Manager\CaptainFinancialSystem\CaptainFinancialDefaultSystem;

use App\Repository\OrderEntityRepository;

class CaptainFinancialDefaultSystemOrderManager
{
    public function __construct(
        private OrderEntityRepository $orderEntityRepository
    )
    {
    }

    public function getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainId, $fromDate,
            $toDate);
    }

//    public function getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
//    {
//        return $this->orderEntityRepository->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
//            $fromDate, $toDate);
//    }
}
