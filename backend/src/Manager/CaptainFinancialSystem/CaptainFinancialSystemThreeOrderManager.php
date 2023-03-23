<?php

namespace App\Manager\CaptainFinancialSystem;

use App\Manager\Order\OrderManager;

class CaptainFinancialSystemThreeOrderManager
{
    private OrderManager $orderManager;

    public function __construct(OrderManager $orderManager)
    {
        $this->orderManager = $orderManager;
    }

    public function getCountOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
       return $this->orderManager->getCountOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    public function getDetailOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    public function getCountOrdersByFinancialSystemThree(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): ?array
    {
        return $this->orderManager->getCountOrdersByFinancialSystemThree($captainId, $fromDate, $toDate, $countKilometersFrom, $countKilometersTo);
    }

    /**
     * Get count of orders without distance and delivered by specific captain during specific time
     */
    public function getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderManager->getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    public function getCancelledOrdersCountByCaptainProfileIdAndSpecificDateAndSpecificDistanceRange(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): ?array
    {
        return $this->orderManager->getCancelledOrdersCountByCaptainProfileIdAndSpecificDateAndSpecificDistanceRange($captainId, $fromDate, $toDate, $countKilometersFrom, $countKilometersTo);
    }

    /**
     * Get count of orders without distance and cancelled by store and related to specific captain during specific time
     */
    public function getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->orderManager->getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);
    }
}
