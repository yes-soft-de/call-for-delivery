<?php

namespace App\Service\Admin\CaptainFinancialSystem\CaptainFinancialSystemOne;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemOneBalanceDetailManager;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse;

class AdminCaptainFinancialSystemOneGetBalanceDetailsService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminCaptainFinancialSystemOneBalanceDetailManager $adminCaptainFinancialSystemOneBalanceDetailManager,
        private AdminCaptainFinancialSystemOneGetStoreAmountService $adminCaptainFinancialSystemOneGetStoreAmountService
    )
    {
    }

    public function getDeliveredOrdersCountByCaptainProfileIdAndSpecificDateForAdmin(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $countOrders = $this->adminCaptainFinancialSystemOneBalanceDetailManager->getCountOrdersByCaptainIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);

        if ($countOrders) {
            if (count($countOrders) > 0) {
                return $countOrders['countOrder'];
            }
        }

        return 0;
    }

    /**
     * Get the count of delivered orders by specific captain and during specific date and which each one overdue the
     * 19 kilometer distance
     */
    public function getOverdueDeliveredOrdersByCaptainProfileIdAndBetweenTwoDatesForAdmin(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $countOrders = $this->adminCaptainFinancialSystemOneBalanceDetailManager->getOverdueDeliveredOrdersByCaptainProfileIdAndBetweenTwoDatesForAdmin($captainProfileId,
            $fromDate, $toDate);

        if (count($countOrders) > 0) {
            return $countOrders[0];
        }

        return 0;
    }

    /**
     * Get count of orders without distance and delivered by specific captain during specific time
     */
    public function getOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDateForAdmin(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $countOrders = $this->adminCaptainFinancialSystemOneBalanceDetailManager->getOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDateForAdmin($captainProfileId,
            $fromDate, $toDate);

        if (count($countOrders) > 0) {
            return $countOrders[0];
        }

        return 0;
    }

    /**
     * Get the dues of unpaid cash orders (for group of orders)
     */
    public function getUnPaidCashOrdersDuesByCaptainProfileIdAndDuringSpecificDateForAdmin(int $captainProfileId, string $fromDate, string $toDate): int
    {
        return (int) $this->adminCaptainFinancialSystemOneGetStoreAmountService->getUnPaidCashOrdersDuesByCaptainProfileIdAndDuringSpecificDateForAdmin($captainProfileId,
            $fromDate, $toDate);
    }

    public function getOrdersDetailsByCaptainProfileIdAndSpecificDateForAdmin(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->adminCaptainFinancialSystemOneBalanceDetailManager->getOrdersByCaptainIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);
    }

    /**
     * Get cancelled orders, by store at 'in store' state, count according to specific captain and dates
     */
    public function getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $ordersCountResult = $this->adminCaptainFinancialSystemOneBalanceDetailManager->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);

        if (count($ordersCountResult) > 0) {
            return $ordersCountResult[0];
        }

        return 0;
    }

    /**
     * Get cancelled orders, by store at 'in store' state, count and which overdue the 19 kilometer according to
     * specific captain and dates
     */
    public function getCancelledAndOverdueStoreBranchToClientDistanceOrdersCountByCaptainProfileIdAndDates(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $ordersCountResult = $this->adminCaptainFinancialSystemOneBalanceDetailManager->getCancelledAndOverdueStoreBranchToClientDistanceOrdersCountByCaptainProfileIdAndDates($captainProfileId,
            $fromDate, $toDate);

        if (count($ordersCountResult) > 0) {
            return $ordersCountResult[0];
        }

        return 0;
    }

    /**
     * Get count of orders without distance and cancelled by store and related to specific captain during specific time
     */
    public function getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $ordersCountResult = $this->adminCaptainFinancialSystemOneBalanceDetailManager->getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);

        if (count($ordersCountResult) > 0) {
            return $ordersCountResult[0];
        }

        return 0;
    }

    /**
     * This function retrieve and initialize necessary fields for captain financial dues calculation
     */
    public function initializeNecessaryFieldsForDuesCalculation(int $captainProfileId, array $datesArray, float $sumPayments, array $financialDetailsArray): array
    {
        // initialize delivered orders count field: delivered orders count according to a specific captain and date
        $financialDetailsArray['countOrders'] = ((float) $this->getDeliveredOrdersCountByCaptainProfileIdAndSpecificDateForAdmin($captainProfileId,
            $datesArray['fromDate'], $datesArray['toDate']))
            + ((float) $this->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
                $datesArray['fromDate'], $datesArray['toDate']) / CaptainFinancialSystem::CANCELLED_ORDER_DIVISION_FACTOR_CONST);

        $financialDetailsArray['sumPayments'] = $sumPayments;

        // initialize order field by getting order details
        $financialDetailsArray['orders'] = $this->getOrdersDetailsByCaptainProfileIdAndSpecificDateForAdmin($captainProfileId,
            $datesArray['fromDate'], $datesArray['toDate']);

        // initialize following field be getting all orders count which overdue the 19 kilometer
        $financialDetailsArray['countOrdersMaxFromNineteen'] = ((float) $this->getOverdueDeliveredOrdersByCaptainProfileIdAndBetweenTwoDatesForAdmin($captainProfileId,
            $datesArray['fromDate'], $datesArray['toDate']))
            + ((float) $this->getCancelledAndOverdueStoreBranchToClientDistanceOrdersCountByCaptainProfileIdAndDates($captainProfileId,
                $datesArray['fromDate'], $datesArray['toDate']) / CaptainFinancialSystem::CANCELLED_ORDER_DIVISION_FACTOR_CONST);

        // initialize following field by getting all orders count which have no distance
        $financialDetailsArray['countOrdersWithoutDistance'] = (float) $this->getOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDateForAdmin($captainProfileId,
            $datesArray['fromDate'], $datesArray['toDate'])
            + ((float) $this->getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainProfileId,
                $datesArray['fromDate'], $datesArray['toDate']) / CaptainFinancialSystem::CANCELLED_ORDER_DIVISION_FACTOR_CONST);

        // initialize following field by getting all due from cash orders for store
        $financialDetailsArray['amountForStore'] = $this->getUnPaidCashOrdersDuesByCaptainProfileIdAndDuringSpecificDateForAdmin($captainProfileId,
            $datesArray['fromDate'], $datesArray['toDate']);

        $financialDetailsArray['dateFinancialCycleStarts'] = $datesArray['fromDate'];

        $financialDetailsArray['dateFinancialCycleEnds'] = $datesArray['toDate'];

        $financialDetailsArray['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_BALANCE_CONST;

        return $financialDetailsArray;
    }

    /**
     * The main function of the service
     * Return a response with details about the financial balance of the captain who subscribed the first financial system
     */
    public function getBalanceDetailWithSystemOne(array $financialSystemDetail, int $captainProfileId, float $sumPayments, array $date, int $countWorkdays): AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse
    {
        $financialSystemDetail = $this->initializeNecessaryFieldsForDuesCalculation($captainProfileId, $date, $sumPayments,
            $financialSystemDetail);

        $financialSystemDetail['financialDues'] = $this->financialDuesCalculator($countWorkdays, $financialSystemDetail['countOrders'],
            $financialSystemDetail['countOrdersMaxFromNineteen'], $financialSystemDetail['compensationForEveryOrder'],
            $financialSystemDetail['salary']);

        $total = $sumPayments - round($financialSystemDetail['financialDues'], 2);

        if ($total <= 0 ) {
            $financialSystemDetail['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_EXIST_CONST;
        }

        $financialSystemDetail['total'] = abs(round($total, 1));

        return $this->autoMapping->map('array', AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse::class, $financialSystemDetail);
    }

    /**
     * If the captain works 25 days he gets the monthly salary, if he works less than 25 days the captain gets the daily salary
     */
    public function financialDuesCalculator(int $countWorkdays, float $countOrdersCompleted, float $countOrdersMaxFromNineteen, float $compensationForEveryOrder, float $salary): float
    {
        //The number of actual working days is 25, if the captain works 25 days or more, he will receive the full monthly salary
        if ($countWorkdays >= 25) {
            return round((($countOrdersCompleted + $countOrdersMaxFromNineteen) * $compensationForEveryOrder)
                + $salary, 2);
        }

        $dailySalary = $salary / 30;

        return round((($countOrdersCompleted + $countOrdersMaxFromNineteen) * $compensationForEveryOrder)
            + $dailySalary, 2);
    }
}
