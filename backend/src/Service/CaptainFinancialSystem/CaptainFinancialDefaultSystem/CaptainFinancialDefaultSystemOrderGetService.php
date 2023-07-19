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

    /**
     * Get delivered (or cancelled under specific circumstances) orders by specific captain and among specific date
     */
    public function getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialDefaultSystemOrderManager->getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);
    }
}
