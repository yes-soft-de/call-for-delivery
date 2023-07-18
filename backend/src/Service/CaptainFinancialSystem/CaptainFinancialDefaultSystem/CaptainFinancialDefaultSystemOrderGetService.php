<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDefaultSystem;

use App\Manager\CaptainFinancialSystem\CaptainFinancialDefaultSystem\CaptainFinancialDefaultSystemOrderManager;

class CaptainFinancialDefaultSystemOrderGetService
{
    public function __construct(
        private CaptainFinancialDefaultSystemOrderManager $captainFinancialDefaultSystemOrderManager
    )
    {
    }

    public function getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialDefaultSystemOrderManager->getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);
    }

//    public function getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
//    {
//        return $this->captainFinancialDefaultSystemOrderManager->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
//            $fromDate, $toDate);
//    }
}
