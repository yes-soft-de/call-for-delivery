<?php

namespace App\Service\Admin\CaptainFinancialSystem\CaptainFinancialSystemTwo;

use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemTwo\CaptainFinancialSystemTwoOrderManager;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwo\CaptainFinancialSystemTwoCalculationService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwo\CaptainFinancialSystemTwoGetStoreAmountService;

// This service responsible for preparing the details of a specific captain financial dues for admin
// Note: Financial dues according to the second financial system (count of orders)

class AdminCaptainFinancialSystemTwoGetBalanceDetailsService
{
    public function __construct(
        private CaptainFinancialSystemTwoOrderManager $captainFinancialSystemTwoOrderManager,
        private CaptainFinancialSystemTwoCalculationService $captainFinancialSystemTwoCalculationService,
        private CaptainFinancialSystemTwoGetStoreAmountService $captainFinancialSystemTwoGetStoreAmountService
    )
    {
    }

    /**
     * Get orders details by specific captain and during specific date
     */
    public function getOrdersDetailsByCaptainProfileIdAndSpecificDate(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialSystemTwoOrderManager->getOrdersByCaptainIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);
    }

    /**
     * Get delivered orders count by specific captain and during specific date
     */
    public function getDeliveredOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $ordersCountResult = $this->captainFinancialSystemTwoOrderManager->getDeliveredOrdersCountByCaptainIdAndBetweenTwoDates($captainProfileId, $fromDate,
            $toDate);

        if (count($ordersCountResult) > 0) {
            return $ordersCountResult[0];
        }

        return 0;
    }

    public function getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $ordersCountResult = $this->captainFinancialSystemTwoOrderManager->getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates($captainProfileId, $fromDate,
            $toDate);

        if (count($ordersCountResult) > 0) {
            return $ordersCountResult[0];
        }

        return 0;
    }

    // Get count of orders without distance and delivered by specific captain during specific time
    public function getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $ordersCountResult = $this->captainFinancialSystemTwoOrderManager->getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate($captainProfileId, $fromDate,
            $toDate);

        if (count($ordersCountResult) > 0) {
            return $ordersCountResult[0];
        }

        return 0;
    }

    public function getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $ordersCountResult = $this->captainFinancialSystemTwoOrderManager->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);

        if (count($ordersCountResult) > 0) {
            return $ordersCountResult[0];
        }

        return 0;
    }

    public function getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $ordersCountResult = $this->captainFinancialSystemTwoOrderManager->getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
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
        $ordersCountResult = $this->captainFinancialSystemTwoOrderManager->getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);

        if (count($ordersCountResult) > 0) {
            return $ordersCountResult[0];
        }

        return 0;
    }

    /**
     *  Get the dues of unpaid cash orders (for group of orders)
     */
    public function getUnPaidCashOrdersDuesByCaptainProfileIdAndDuringSpecificTime(int $captainProfileId, string $fromDate, string $toDate): int
    {
        return (int) $this->captainFinancialSystemTwoGetStoreAmountService->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainProfileId,
            $fromDate, $toDate);
    }

    public function getBalanceDetailsForAdmin(int $captainId, array $financialSystemDetail, float $sumPayments, array $datesArray): array
    {
        $balanceDetailsResponse = [];
        $total = 0.0;

        // Initialize some fields in the response before doing the required calculations
        $balanceDetailsResponse = $this->initializeNecessaryFieldsForDuesCalculation($captainId, $datesArray, $sumPayments);

        // Check if captain accomplish the target, or not, or beyond it
        $checkTarget = $this->checkAchievedFinancialSystemTarget($financialSystemDetail['countOrdersInMonth'], $balanceDetailsResponse['countOrdersCompleted']);

        if ($checkTarget === CaptainFinancialSystem::TARGET_SUCCESS_INT) {
            $balanceDetailsResponse['salary'] = $financialSystemDetail['salary'];

            $balanceDetailsResponse['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $balanceDetailsResponse['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS;

        } elseif ($checkTarget === CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE_INT) {
            $balanceDetailsResponse['salary'] = $financialSystemDetail['salary'];

            $balanceDetailsResponse['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $balanceDetailsResponse['countOverOrdersThanRequired'] = $balanceDetailsResponse['countOrdersCompleted'] - $financialSystemDetail['countOrdersInMonth'];

            $balanceDetailsResponse['bounce'] = round($balanceDetailsResponse['countOverOrdersThanRequired'] * $financialSystemDetail['bounceMaxCountOrdersInMonth'], 2);

            $balanceDetailsResponse['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE;

        } elseif ($checkTarget === CaptainFinancialSystem::TARGET_FAILED_INT) {
            $balanceDetailsResponse['salary'] = $financialSystemDetail['salary'];

            $balanceDetailsResponse['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_FAILED;
        }

        // Call the function responsible for the core calculation of the financial dues
        $balanceDetailsResponse['financialDues'] = $this->captainFinancialSystemTwoCalculationService->calculateFinancialDues($checkTarget,
            $financialSystemDetail['salary'], $financialSystemDetail['monthCompensation'], $balanceDetailsResponse['countOrdersCompleted'],
            $financialSystemDetail['countOrdersInMonth'], $financialSystemDetail['bounceMaxCountOrdersInMonth']);

        $total = round(($sumPayments - $balanceDetailsResponse['financialDues']), 2);

        $balanceDetailsResponse['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_BALANCE_CONST;

        if ($total <= 0) {
            $balanceDetailsResponse['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_EXIST_CONST;
        }

        $balanceDetailsResponse['total'] = abs($total);

        return $balanceDetailsResponse;
    }

    // Check if captain accomplish the target of the financial system, or not, or beyond
    public function checkAchievedFinancialSystemTarget(int $countOrdersInMonth, float $countOrdersCompleted): int
    {
        if ($countOrdersCompleted < $countOrdersInMonth) {
            return CaptainFinancialSystem::TARGET_FAILED_INT;

        } elseif ($countOrdersCompleted === (float) $countOrdersInMonth) {
            return  CaptainFinancialSystem::TARGET_SUCCESS_INT;

        } else {
            // $countOrdersCompleted > $countOrdersInMonth
            return  CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE_INT;
        }
    }

    // This function retrieve and initialize necessary fields for captain financial dues calculation
    public function initializeNecessaryFieldsForDuesCalculation(int $captainProfileId, array $datesArray, float $sumPayments): array
    {
        $response = [];

        $response['salary'] = 0.0;
        $response['monthCompensation'] = 0.0;
        $response['countOverOrdersThanRequired'] = 0;
        $response['bounce'] = 0.0;
        $response['financialDues'] = 0.0;
        $response['total'] = 0.0;
        $response['orders'] = $this->getOrdersDetailsByCaptainProfileIdAndSpecificDate($captainProfileId, $datesArray['fromDate'],
            $datesArray['toDate']);

        // Get the count of delivered orders by specific captain and between two dates
        $response['countOrdersCompleted'] = ((float) $this->getDeliveredOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $datesArray['fromDate'], $datesArray['toDate']))
        + ((float) $this->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
                $datesArray['fromDate'], $datesArray['toDate']) / CaptainFinancialSystem::CANCELLED_ORDER_DIVISION_FACTOR_CONST);

        // Get delivered orders of the captain between two dates and which overdue the 19 Kilometer
        $response['countOrdersMaxFromNineteen'] = ((float) $this->getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates($captainProfileId,
            $datesArray['fromDate'], $datesArray['toDate']))
        + ((float) $this->getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId, $datesArray['fromDate'],
                $datesArray['toDate']) / CaptainFinancialSystem::CANCELLED_ORDER_DIVISION_FACTOR_CONST);

        $response['countOrdersCompleted'] += $response['countOrdersMaxFromNineteen'];

        $response['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_NOT_ARRIVED;

        $response['dateFinancialCycleEnds'] = $datesArray['toDate'];
        $response['dateFinancialCycleStarts'] = $datesArray['fromDate'];

        $response['sumPayments'] = $sumPayments;

        // Get count of orders without distance which delivered by the captain and during specific dates
        $response['countOrdersWithoutDistance'] = ((float) $this->getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate($captainProfileId,
            $datesArray['fromDate'], $datesArray['toDate']))
        + ((float) $this->getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainProfileId, $datesArray['fromDate'],
                $datesArray['toDate']) / CaptainFinancialSystem::CANCELLED_ORDER_DIVISION_FACTOR_CONST);

        // Get the total amount for store from unpaid cash orders which delivered by the captain during specific dates
        $response['amountForStore'] = $this->getUnPaidCashOrdersDuesByCaptainProfileIdAndDuringSpecificTime($captainProfileId,
            $datesArray['fromDate'], $datesArray['toDate']);

        return $response;
    }
}
