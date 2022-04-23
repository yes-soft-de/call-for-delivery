<?php

namespace App\Manager\Admin\CaptainFinancialSystem;

use App\Manager\Order\OrderManager;

class AdminCaptainFinancialSystemTwoBalanceDetailManager
{
    private OrderManager $orderManager;

    public function __construct(OrderManager $orderManager)
    {
        $this->orderManager = $orderManager;
    }

    public function getCountOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate)
    {
       return $this->orderManager->getCountOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    public function getDetailOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate)
    {
        return $this->orderManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }
}
