<?php

namespace App\Manager\Admin\CaptainFinancialSystem;

use App\Repository\OrderEntityRepository;

class AdminCaptainFinancialSystemOneBalanceDetailManager
{
    public function __construct(
        private OrderEntityRepository $orderEntityRepository
    )
    {
    }

    public function getCountOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getCountOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    public function getDetailOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    public function getOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    /**
     * Get the count of delivered orders by specific captain and during specific date and which each one overdue the
     * 19 kilometer distance
     */
    public function getOverdueDeliveredOrdersByCaptainProfileIdAndBetweenTwoDatesForAdmin(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);
    }

    /**
     * Get count of orders without distance and delivered by specific captain during specific time
     */
    public function getOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDateForAdmin(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);
    }

    /**
     * Get cancelled orders, by store at 'in store' state, count according to specific captain and dates
     */
    public function getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);
    }

    /**
     * Get cancelled orders, by store at 'in store' state, count and which overdue the 19 kilometer according to
     * specific captain and dates
     */
    public function getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
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
