<?php

namespace App\Manager\Admin\CaptainFinancialSystem;

use App\Repository\OrderEntityRepository;

class AdminCaptainFinancialSystemThreeBalanceDetailManager
{
    public function __construct(
        private OrderEntityRepository $orderEntityRepository
    )
    {
    }

    public function getDetailOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    public function getCountOrdersByFinancialSystemThree(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): ?array
    {
        return $this->orderEntityRepository->getCountOrdersByFinancialSystemThree($captainId, $fromDate, $toDate,
            $countKilometersFrom, $countKilometersTo);
    }

    public function getOrdersByFinancialSystemThree(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): ?array
    {
        return $this->orderEntityRepository->getOrdersByFinancialSystemThree($captainId, $fromDate, $toDate,
            $countKilometersFrom, $countKilometersTo);
    }

    /**
     * Get all orders with details that delivered by specific captain during specific date and storeBranchToClientDistance
     * for each order belong to the specific category of the third financial system
     */
    public function getOrdersDetailsByFinancialSystemThree(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): array
    {
        return $this->orderEntityRepository->getOrdersDetailsByFinancialSystemThree($captainId, $fromDate, $toDate,
            $countKilometersFrom, $countKilometersTo);
    }

    /**
     * Get count of orders without distance and delivered by specific captain during specific time
     */
    public function getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate($captainId, $fromDate,
            $toDate);
    }

    /**
     * Get count of orders without distance and cancelled by store and related to specific captain during specific time
     */
    public function getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);
    }

    /**
     * Get cancelled orders, by store at 'in store' state, count according to specific captain and dates
     */
    public function getCancelledOrdersCountByCaptainProfileIdAndSpecificDateAndSpecificDistanceRange(int $captainProfileId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): array
    {
        return $this->orderEntityRepository->getCancelledOrdersCountByCaptainProfileIdAndSpecificDateAndSpecificDistanceRange($captainProfileId,
            $fromDate, $toDate, $countKilometersFrom, $countKilometersTo);
    }
}
