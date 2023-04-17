<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwo;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse;

/**
 * This service responsible for preparing the details of a specific captain financial dues for captain him/her self
 * Note: Financial dues according to the second financial system (count of orders)
 */
class CaptainFinancialSystemTwoGetBalanceDetailsService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private CaptainFinancialSystemTwoCalculationService $captainFinancialSystemTwoCalculationService,
        private CaptainFinancialSystemTwoGetStoreAmountService $captainFinancialSystemTwoGetStoreAmountService,
        private CaptainFinancialSystemTwoOrderGetService $captainFinancialSystemTwoOrderGetService
    )
    {
    }

    /**
     * Get the count of cancelled orders which overdue the 19 Kilometer and related to a specific captain and among specific date
     */
    public function getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): int
    {
        $overdueOrdersResult = $this->captainFinancialSystemTwoOrderGetService->getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates($captainId, $fromDate, $toDate);

        if (count($overdueOrdersResult) > 0) {
            return $overdueOrdersResult[0];
        }

        return 0;
    }

    /**
     * Get the count of delivered orders which have no distance by specific captain and among specific date
     */
    public function getOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $result = $this->captainFinancialSystemTwoOrderGetService->getOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);

        if (count($result) > 0) {
            return $result[0];
        }

        return 0;
    }

    /**
     * Get the count of delivered orders which overdue the 19 kilometer by specific captain and among specific date
     */
    public function getOverdueDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $overdueOrdersResult = $this->captainFinancialSystemTwoOrderGetService->getOverdueDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);

        if (count($overdueOrdersResult) > 0) {
            return $overdueOrdersResult[0];
        }

        return 0;
    }

    /**
     * Get the count of delivered orders by specific captain and among specific date
     */
    public function getDeliveredOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $ordersCountResult = $this->captainFinancialSystemTwoOrderGetService->getDeliveredOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);

        if (count($ordersCountResult) > 0) {
            return $ordersCountResult[0];
        }

        return 0;
    }

    /**
     * Get the count of cancelled orders and related to a specific captain and among specific date
     */
    public function getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $countOrdersResult = $this->captainFinancialSystemTwoOrderGetService->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);

        if (count($countOrdersResult) > 0) {
            return $countOrdersResult[0];
        }

        return 0;
    }

    /**
     * Get count of orders without distance and cancelled by store and related to specific captain during specific time
     */
    public function getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $countOrdersResult = $this->captainFinancialSystemTwoOrderGetService->getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);

        if (count($countOrdersResult) > 0) {
            return $countOrdersResult[0];
        }

        return 0;
    }

    // Get the dues of unpaid cash orders (for group of orders)
    public function getUnPaidCashOrdersDueByCaptainProfileIdAndDuringSpecificTime(int $captainId, string $fromDate, string $toDate): string
    {
        return $this->captainFinancialSystemTwoGetStoreAmountService->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainId,
            $fromDate, $toDate);
    }

    public function calculateFinancialDues(int $targetStatus, float $salary, float $monthCompensation, float $countOrdersCompleted = null,
                                           int $countOrdersInMonth = null, float $bounceMaxCountOrdersInMonth = null): float
    {
        return $this->captainFinancialSystemTwoCalculationService->calculateFinancialDues($targetStatus, $salary,
            $monthCompensation, $countOrdersCompleted, $countOrdersInMonth, $bounceMaxCountOrdersInMonth);
    }

    public function getBalanceDetails(int $captainId, array $datesArray, float $sumPayments, array $financialSystemDetail): CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse
    {
        $total = 0.0;
        $response = $this->initializeNecessaryFieldsForDuesCalculation($captainId, $datesArray, $financialSystemDetail);

        $response['countOverOrdersThanRequired'] = 0;
        $response['bounce'] = 0.0;
        $response['total'] = 0.0;

        $response['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_NOT_ARRIVED;

        $response['dateFinancialCycleStarts'] = $datesArray['fromDate'];
        $response['dateFinancialCycleEnds'] = $datesArray['toDate'];

        $response['sumPayments'] = $sumPayments;

        // Get count of orders without distance which delivered by the captain and during specific dates
        $response['countOrdersWithoutDistance'] = (float) $this->getOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainId,
            $datesArray['fromDate'], $datesArray['toDate']) +
            ((float) $this->getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainId,
                $datesArray['fromDate'], $datesArray['toDate']) / CaptainFinancialSystem::CANCELLED_ORDER_DIVISION_FACTOR_CONST);

        // Check if captain accomplish the target of the financial system, or not, or beyond
        $checkTarget = $this->checkAchievedFinancialSystemTarget($financialSystemDetail['countOrdersInMonth'],
            $response['countOrdersCompleted']);

        if ($checkTarget === CaptainFinancialSystem::TARGET_SUCCESS_INT) {
            // captain dues = salary + month compensation
            $response['salary'] = $financialSystemDetail['salary'];

            $response['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $response['countOrdersInMonth'] = $financialSystemDetail['countOrdersInMonth'];

            $response['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS;

        } elseif ($checkTarget === CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE_INT) {
            // captain dues = salary + month compensation + (number of overdue orders * bounceMaxCountOrdersInMonth)
            $response['salary'] = $financialSystemDetail['salary'];

            $response['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $response['countOrdersInMonth'] = $financialSystemDetail['countOrdersInMonth'];

            $response['countOverOrdersThanRequired'] = $response['countOrdersCompleted'] - $financialSystemDetail['countOrdersInMonth'];

            $response['bounce'] = round($response['countOverOrdersThanRequired'] * $financialSystemDetail['bounceMaxCountOrdersInMonth'], 2);

            $response['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE;

        } elseif ($checkTarget === CaptainFinancialSystem::TARGET_FAILED_INT) {
            // captain dues = number of completed orders * (1900 / 150)
            $response['salary'] = $financialSystemDetail['salary'];

            $response['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $response['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_FAILED;

            $response['countOrdersInMonth'] = $financialSystemDetail['countOrdersInMonth'];
        }

        // Call the function responsible for the core calculation of the financial dues
        $response['financialDues'] = $this->captainFinancialSystemTwoCalculationService->calculateFinancialDues($checkTarget,
            $financialSystemDetail['salary'], $financialSystemDetail['monthCompensation'], $response['countOrdersCompleted'],
            $financialSystemDetail['countOrdersInMonth'], $financialSystemDetail['bounceMaxCountOrdersInMonth']);

        $total = round(($response['financialDues'] - $sumPayments), 2);

        $response['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_NOT_EXIST_CONST;

        if ($total < 0) {
            $response['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_EXIST_CONST;

        } elseif ($total == 0) {
            $response['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_BALANCE_CONST;
        }

        $response['total'] = abs($total);

        return $this->autoMapping->map('array', CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse::class, $response);
    }

    // To prepare the financial details for the captain
    public function calculateCaptainDues(int $captainId, array $financialSystemDetail, array $datesArray): array
    {
        $response = $this->initializeNecessaryFieldsForDuesCalculation($captainId, $datesArray, $financialSystemDetail);

        // Check if the captain achieve the target of the financial system
        $checkTarget = $this->checkAchievedFinancialSystemTarget($financialSystemDetail['countOrdersInMonth'],
            $response['countOrdersCompleted']);

        // Calculate the financial dues according to the achieved target
        if ($checkTarget === CaptainFinancialSystem::TARGET_SUCCESS_INT) {
            // captain will get the salary + month compensation
            $response['salary'] = $financialSystemDetail['salary'];

            $response['monthCompensation'] = $financialSystemDetail['monthCompensation'];

        } elseif ($checkTarget === CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE_INT) {
            // Captain will get the salary + month compensation + (25 for each order overdue 19 Kilo)
            $response['salary'] = $financialSystemDetail['salary'];

            $response['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $response['countOverOrdersThanRequired'] = $response['countOrdersCompleted'] - $financialSystemDetail['countOrdersInMonth'];

            $response['bounce'] = $response['countOverOrdersThanRequired'] * $financialSystemDetail['bounceMaxCountOrdersInMonth'];

            $response['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE;
        }
//        elseif ($checkTarget === CaptainFinancialSystem::TARGET_FAILED_INT) {
//            // Captain will get 1900/150 * completed orders = 12.86 * completed orders
//            $response['financialDues'] = $response['countOrdersCompleted'] * CaptainFinancialSystem::TARGET_FAILED_SALARY;
//        }

        // Call the function responsible for the core calculation of the financial dues
        $response['financialDues'] = $this->calculateFinancialDues($checkTarget, $financialSystemDetail['salary'],
            $financialSystemDetail['monthCompensation'], $response['countOrdersCompleted'], $financialSystemDetail['countOrdersInMonth'],
            $financialSystemDetail['bounceMaxCountOrdersInMonth']);

        return $response;
    }

    // Check if captain accomplish the target of the financial system, or not, or beyond
    public function checkAchievedFinancialSystemTarget(int $countOrdersInMonth, float $countOrdersCompleted): int
    {
        if ($countOrdersCompleted < (float) $countOrdersInMonth) {
            return CaptainFinancialSystem::TARGET_FAILED_INT;

        } elseif ($countOrdersCompleted === (float) $countOrdersInMonth) {
            return  CaptainFinancialSystem::TARGET_SUCCESS_INT;

        } else {
            // $countOrdersCompleted > $countOrdersInMonth
            return  CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE_INT;
        }
    }

    // This function retrieve and initialize necessary fields for captain financial dues calculation
    public function initializeNecessaryFieldsForDuesCalculation(int $captainId, array $datesArray, array $financialSystemDetail): array
    {
        $response = [];

        $response['captainFinancialSystemType'] = $financialSystemDetail['captainFinancialSystemType'];
        $response['salary'] = 0.0;
        $response['monthCompensation'] = 0;
        $response['financialDues'] = 0.0;

        // cash orders sum (which will be forwarded from captain to administration
        $response['amountForStore'] = 0.0;

        // Get delivered orders of the captain between two dates and which overdue the 19 Kilometer
        // besides half of the cancelled orders count which also overdue the 19 Kilometer
        $response['countOrdersMaxFromNineteen'] = ((float) $this->getOverdueDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainId,
            $datesArray['fromDate'], $datesArray['toDate']) +
            ((float) $this->getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates($captainId,
                $datesArray['fromDate'], $datesArray['toDate'])) / CaptainFinancialSystem::CANCELLED_ORDER_DIVISION_FACTOR_CONST);

        // Get the count of delivered orders by specific captain and between two dates
        // besides half of the cancelled orders count
        $response['countOrdersCompleted'] = ((float) $this->getDeliveredOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainId,
            $datesArray['fromDate'], $datesArray['toDate']) +
            ((float) $this->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainId,
                $datesArray['fromDate'], $datesArray['toDate'])) / CaptainFinancialSystem::CANCELLED_ORDER_DIVISION_FACTOR_CONST);

        // Each order overdue 19 Kilometer will be counted as two orders
        $response['countOrdersCompleted'] += $response['countOrdersMaxFromNineteen'];

        // Get the sum amount of the dues of unpaid cash orders that the captain delivers during specific time
        $response['amountForStore'] = $this->getUnPaidCashOrdersDueByCaptainProfileIdAndDuringSpecificTime($captainId,
            $datesArray['fromDate'], $datesArray['toDate']);

        return $response;
    }
}
