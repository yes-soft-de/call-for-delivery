<?php

namespace App\Service\Admin\CaptainFinancialSystem\CaptainFinancialSystemTwo;

use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\GeoDistance\GeoDistanceResultConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Manager\Admin\CaptainFinancialSystem\CaptainFinancialSystemTwo\AdminCaptainFinancialSystemTwoOrderManager;

// This service responsible for handling calculating the dues of a captain subscribed with
// the second financial system (According to count of orders)

class AdminCaptainFinancialSystemTwoCalculationService
{
    private AdminCaptainFinancialSystemTwoOrderManager $adminCaptainFinancialSystemTwoOrderManager;

    public function __construct(AdminCaptainFinancialSystemTwoOrderManager $adminCaptainFinancialSystemTwoOrderManager)
    {
        $this->adminCaptainFinancialSystemTwoOrderManager = $adminCaptainFinancialSystemTwoOrderManager;
    }

    public function getBalanceDetailsForAdmin(int $captainId, array $financialSystemDetail, float $sumPayments, array $datesArray): array
    {
        $balanceDetailsResponse = [];
        $total = 0.0;

        // Initialize some fields in the response before doing the required calculations
        $balanceDetailsResponse = $this->initializeNecessaryFieldsForDuesCalculation($captainId, $datesArray, $sumPayments);

        // Get thr details of delivered orders by specific captain and between two dates in order to calculate some values
        $detailsOrders = $this->adminCaptainFinancialSystemTwoOrderManager->getDetailOrdersByCaptainIdOnSpecificDateForAdmin($captainId,
            $datesArray['fromDate'], $datesArray['toDate']);

        foreach ($detailsOrders as $orderDetail) {
            // Get the number of orders that does not have a distance
            if ($orderDetail['storeBranchToClientDistance'] === null || $orderDetail['storeBranchToClientDistance'] === (float)GeoDistanceResultConstant::ZERO_DISTANCE_CONST ) {
                $balanceDetailsResponse['countOrdersWithoutDistance'] += 1;
            }

            if ($orderDetail['payment'] === OrderTypeConstant::ORDER_PAYMENT_CASH && $orderDetail['paidToProvider'] === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO ) {
                $balanceDetailsResponse['amountForStore'] += $orderDetail['captainOrderCost'];
            }
        }

        // Check if captain accomplish the target, or not, or beyond it
        $checkTarget = $this->checkAchievedFinancialSystemTarget($financialSystemDetail['countOrdersInMonth'], $balanceDetailsResponse['countOrdersCompleted']);

        if ($checkTarget === CaptainFinancialSystem::TARGET_SUCCESS_INT) {
            $balanceDetailsResponse['salary'] = $financialSystemDetail['salary'];

            $balanceDetailsResponse['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $balanceDetailsResponse['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS;

            $balanceDetailsResponse['financialDues'] = $balanceDetailsResponse['salary'] + $balanceDetailsResponse['monthCompensation'];

            $total = $sumPayments - $balanceDetailsResponse['financialDues'];

        } elseif ($checkTarget === CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE_INT) {
            $balanceDetailsResponse['salary'] = $financialSystemDetail['salary'];

            $balanceDetailsResponse['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $balanceDetailsResponse['countOverOrdersThanRequired'] = $balanceDetailsResponse['countOrdersCompleted'] - $financialSystemDetail['countOrdersInMonth'];

            $balanceDetailsResponse['bounce'] = round($balanceDetailsResponse['countOverOrdersThanRequired'] * $financialSystemDetail['bounceMaxCountOrdersInMonth'], 2);

            $balanceDetailsResponse['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE;

            $balanceDetailsResponse['financialDues'] = round($balanceDetailsResponse['salary'] + $balanceDetailsResponse['monthCompensation'] + $balanceDetailsResponse['bounce'], 2);

            $total = $sumPayments - round($balanceDetailsResponse['financialDues'], 2);

        } elseif ($checkTarget === CaptainFinancialSystem::TARGET_FAILED_INT) {
            $balanceDetailsResponse['salary'] = $financialSystemDetail['salary'];

            $balanceDetailsResponse['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_FAILED;

            $balanceDetailsResponse['financialDues'] = $balanceDetailsResponse['countOrdersCompleted'] * CaptainFinancialSystem::TARGET_FAILED_SALARY;

            $total = round($sumPayments - $balanceDetailsResponse['financialDues'], 2);
        }

        $balanceDetailsResponse['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;

        if ($total <= 0 ) {
            $balanceDetailsResponse['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;
        }

        $balanceDetailsResponse['total'] = abs($total);

        return $balanceDetailsResponse;
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
    public function initializeNecessaryFieldsForDuesCalculation(int $captainId, array $datesArray, float $sumPayments): array
    {
        $response = [];

        $response['salary'] = 0.0;
        $response['monthCompensation'] = 0.0;
        $response['countOverOrdersThanRequired'] = 0;
        $response['bounce'] = 0.0;
        $response['financialDues'] = 0.0;
        $response['total'] = 0.0;

        // Get the count of delivered orders by specific captain and between two dates
        $ordersCountResult = $this->adminCaptainFinancialSystemTwoOrderManager->getDeliveredOrdersCountByCaptainIdAndBetweenTwoDatesForAdmin($captainId,
            $datesArray['fromDate'], $datesArray['toDate']);

        $response['countOrdersCompleted'] = $ordersCountResult[0];

        // Get delivered orders of the captain between two dates and which overdue the 19 Kilometer
        $overdueOrdersResult = $this->adminCaptainFinancialSystemTwoOrderManager->getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDatesForAdmin($captainId,
            $datesArray['fromDate'], $datesArray['toDate']);

        $response['countOrdersMaxFromNineteen'] = $overdueOrdersResult[0];

        $response['countOrdersCompleted'] += $response['countOrdersMaxFromNineteen'];

        $response['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_NOT_ARRIVED;

        $response['dateFinancialCycleEnds'] = $datesArray['toDate'];
        $response['dateFinancialCycleStarts'] = $datesArray['fromDate'];

        $response['sumPayments'] = $sumPayments;

        $response['amountForStore'] = 0.0;
        $response['countOrdersMaxFromNineteen'] = 0;
        $response['countOrdersWithoutDistance'] = 0;

        return $response;
    }
}
