<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwo;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\GeoDistance\GeoDistanceResultConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemTwo\CaptainFinancialSystemTwoOrderManager;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse;

// This service responsible for handling calculating the dues of a captain subscribed with
// the second financial system (According to count of orders)

class CaptainFinancialSystemTwoGetBalanceDetailsService
{
    private AutoMapping $autoMapping;
    private CaptainFinancialSystemTwoOrderManager $captainFinancialSystemTwoOrderManager;
    private CaptainFinancialSystemTwoCalculationService $captainFinancialSystemTwoCalculationService;
    private CaptainFinancialSystemTwoGetStoreAmountService $captainFinancialSystemTwoGetStoreAmountService;

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemTwoOrderManager $captainFinancialSystemTwoOrderManager,
                                CaptainFinancialSystemTwoCalculationService $captainFinancialSystemTwoCalculationService, CaptainFinancialSystemTwoGetStoreAmountService $captainFinancialSystemTwoGetStoreAmountService)
    {
        $this->autoMapping = $autoMapping;
        $this->captainFinancialSystemTwoOrderManager = $captainFinancialSystemTwoOrderManager;
        $this->captainFinancialSystemTwoCalculationService = $captainFinancialSystemTwoCalculationService;
        $this->captainFinancialSystemTwoGetStoreAmountService = $captainFinancialSystemTwoGetStoreAmountService;
    }

    public function getBalanceDetails(int $captainId, array $datesArray, float $sumPayments, array $financialSystemDetail): CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse
    {
        $total = 0.0;
        $response = $this->initializeNecessaryFieldsForDuesCalculation($captainId, $datesArray);

        $response['countOverOrdersThanRequired'] = 0;
        $response['bounce'] = 0.0;
        $response['total'] = 0.0;

        $response['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_NOT_ARRIVED;

        $response['dateFinancialCycleStarts'] = $datesArray['fromDate'];
        $response['dateFinancialCycleEnds'] = $datesArray['toDate'];

        $response['sumPayments'] = $sumPayments;

        $response['countOrdersWithoutDistance'] = 0;

        // Get thr details of delivered orders by specific captain and between two dates
        $detailsOrders = $this->captainFinancialSystemTwoOrderManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId,
            $datesArray['fromDate'], $datesArray['toDate']);

        foreach ($detailsOrders as $orderDetail) {
            // Get orders which are without distance
            if ($orderDetail['storeBranchToClientDistance'] === null || $orderDetail['storeBranchToClientDistance'] === (float)GeoDistanceResultConstant::ZERO_DISTANCE_CONST ) {
                $response['countOrdersWithoutDistance'] += 1;
            }
        }

        // Get the sum amount of the dues of unpaid cash orders that the captain delivers during specific time
        $response['amountForStore'] = $this->captainFinancialSystemTwoGetStoreAmountService->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainId,
            $datesArray['fromDate'], $datesArray['toDate']);

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

        $total = $response['financialDues'] - $sumPayments;

        $response['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;

        if($total <= 0) {
            $response['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;
        }

        $response['total'] = abs($total);

        return $this->autoMapping->map('array', CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse::class, $response);
    }

    // CORE FUNCTION OF CALCULATING THE DUES OF THE CAPTAIN
    public function calculateCaptainDues(int $captainId, array $financialSystemDetail, array $datesArray): array
    {
        $response = $this->initializeNecessaryFieldsForDuesCalculation($captainId, $datesArray);

        // Get thr details of delivered orders by specific captain and between two dates
        $detailsOrders = $this->captainFinancialSystemTwoOrderManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId,
            $datesArray['fromDate'], $datesArray['toDate']);

        foreach ($detailsOrders as $orderDetail) {
            if ($orderDetail['payment'] === OrderTypeConstant::ORDER_PAYMENT_CASH &&
                $orderDetail['paidToProvider'] === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
                $response['amountForStore'] += $orderDetail['captainOrderCost'];
            }
        }

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
        $response['financialDues'] = $this->captainFinancialSystemTwoCalculationService->calculateFinancialDues($checkTarget,
            $financialSystemDetail['salary'], $financialSystemDetail['monthCompensation'], $response['countOrdersCompleted'],
            $financialSystemDetail['countOrdersInMonth'], $financialSystemDetail['bounceMaxCountOrdersInMonth']);

        return $response;
    }

    // Check if captain accomplish the target of the financial system, or not, or beyond
    public function checkAchievedFinancialSystemTarget(int $countOrdersInMonth, int $countOrdersCompleted): int
    {
        if ($countOrdersCompleted < $countOrdersInMonth) {
            return CaptainFinancialSystem::TARGET_FAILED_INT;

        } elseif ($countOrdersCompleted === $countOrdersInMonth) {
            return  CaptainFinancialSystem::TARGET_SUCCESS_INT;

        } else {
            // $countOrdersCompleted > $countOrdersInMonth
            return  CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE_INT;
        }
    }

    // This function retrieve and initialize necessary fields for captain financial dues calculation
    public function initializeNecessaryFieldsForDuesCalculation(int $captainId, array $datesArray): array
    {
        $response = [];

        $response['salary'] = 0.0;
        $response['monthCompensation'] = 0;
        $response['financialDues'] = 0.0;

        // cash orders sum (which will be forwarded from captain to administration
        $response['amountForStore'] = 0.0;

        // Get delivered orders of the captain between two dates and which overdue the 19 Kilometer
        $overdueOrdersResult = $this->captainFinancialSystemTwoOrderManager->getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates($captainId,
            $datesArray['fromDate'], $datesArray['toDate']);

        $response['countOrdersMaxFromNineteen'] = $overdueOrdersResult[0];

        // Get the count of delivered orders by specific captain and between two dates
        $ordersCountResult = $this->captainFinancialSystemTwoOrderManager->getDeliveredOrdersCountByCaptainIdAndBetweenTwoDates($captainId,
            $datesArray['fromDate'], $datesArray['toDate']);

        $response['countOrdersCompleted'] = $ordersCountResult[0];

        // Each order overdue 19 Kilometer will be counted as two orders
        $response['countOrdersCompleted'] += $response['countOrdersMaxFromNineteen'];

        return $response;
    }
}
