<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemOne;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse;

class CaptainFinancialSystemOneGetBalanceDetailsService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private CaptainFinancialSystemOneOrderGetService $captainFinancialSystemOneOrderGetService,
        private CaptainFinancialSystemStoreCashAmountGetService $captainFinancialSystemStoreCashAmountGetService
    )
    {
    }

    public function getDeliveredOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $countOrdersResult = $this->captainFinancialSystemOneOrderGetService->getDeliveredOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);

        if (count($countOrdersResult) > 0) {
            return $countOrdersResult[0];
        }

        return 0;
    }

    public function getOverdueDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): int
    {
        $overdueOrdersResult = $this->captainFinancialSystemOneOrderGetService->getOverdueDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainId, $fromDate, $toDate);

        if (count($overdueOrdersResult) > 0) {
            return $overdueOrdersResult[0];
        }

        return 0;
    }

    // Get the dues of unpaid cash orders (for group of orders)
    public function getUnPaidCashOrdersDuesByCaptainProfileIdAndDuringSpecificTime(int $captainProfileId, string $fromDate, string $toDate): int
    {
        return (int) $this->captainFinancialSystemStoreCashAmountGetService->getUnPaidCashOrdersDuesByCaptainProfileIdAndDuringSpecificTime($captainProfileId,
            $fromDate, $toDate);
    }

    // Get count of orders without distance and delivered by specific captain during specific time
    public function getOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $result = $this->captainFinancialSystemOneOrderGetService->getOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);

        if (count($result) > 0) {
            return $result[0];
        }

        return 0;
    }

    public function getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $countOrdersResult = $this->captainFinancialSystemOneOrderGetService->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);

        if (count($countOrdersResult) > 0) {
            return $countOrdersResult[0];
        }

        return 0;
    }

    public function getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): int
    {
        $overdueOrdersResult = $this->captainFinancialSystemOneOrderGetService->getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates($captainId, $fromDate, $toDate);

        if (count($overdueOrdersResult) > 0) {
            return $overdueOrdersResult[0];
        }

        return 0;
    }

    // Get count of orders without distance and delivered by specific captain during specific time
    public function getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $result = $this->captainFinancialSystemOneOrderGetService->getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);

        if (count($result) > 0) {
            return $result[0];
        }

        return 0;
    }

    // To prepare the financial details for the captain
    public function calculateCaptainDues(array $financialSystemDetail, int $captainProfileId, array $date, int $countWorkdays): array
    {
        //get the count of delivered orders by captain
        $countOrders = $this->getDeliveredOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId, $date['fromDate'],
            $date['toDate']);

        $cancelledOrdersCount = $this->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId, $date['fromDate'],
            $date['toDate']);

        $totalOrdersCount = (float) $countOrders + ((float) $cancelledOrdersCount / 2.0);

        //get the count of orders which overdue the 19 kilometer
        $countOrdersMaxFromNineteen = $this->getOverdueDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $date['fromDate'], $date['toDate']);

        //get the count of orders which overdue the 19 kilometer
        $overdueCancelledOrdersCount = $this->getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $date['fromDate'], $date['toDate']);

        $totalOverdueOrdersCount = (float) $countOrdersMaxFromNineteen + ((float) $overdueCancelledOrdersCount / 2.0);

        $financialSystemDetail['financialDues'] = $this->financialDuesCalculator($countWorkdays, $totalOrdersCount, $totalOverdueOrdersCount,
            $financialSystemDetail['compensationForEveryOrder'], $financialSystemDetail['salary']);

        //The amount received by the captain in cash from the orders, this amount will be handed over to the admin
        $financialSystemDetail['amountForStore'] = $this->getUnPaidCashOrdersDuesByCaptainProfileIdAndDuringSpecificTime($captainProfileId,
            $date['fromDate'], $date['toDate']);

        return $financialSystemDetail;
    }

    //If the captain works 25 days he gets the monthly salary, if he works less than 25 days the captain gets the daily salary
    public function financialDuesCalculator(int $countWorkdays, float $countOrdersCompleted, float $countOrdersMaxFromNineteen, float $compensationForEveryOrder, float $salary): float
    {
        if ($countWorkdays >= 25) {
            return round((($countOrdersCompleted + $countOrdersMaxFromNineteen) * $compensationForEveryOrder ) + $salary,
                2);
        }

        $dailySalary = $salary / 30;

        return round((($countOrdersCompleted + $countOrdersMaxFromNineteen) * $compensationForEveryOrder ) + ($dailySalary * $countWorkdays), 2);
    }

    // This function retrieve and initialize necessary fields for captain financial dues calculation
    public function initializeNecessaryFieldsForDuesCalculation(int $captainProfileId, array $datesArray, float $sumPayments, array $response): array
    {
        //get Count Orders
        $response['countOrders'] = (float) $this->getDeliveredOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $datesArray['fromDate'], $datesArray['toDate']) +
            ((float) $this->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId, $datesArray['fromDate'],
                    $datesArray['toDate']) / 2.0);

        $response['countOrdersMaxFromNineteen'] = (float) $this->getOverdueDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $datesArray['fromDate'], $datesArray['toDate']) +
            ((float) $this->getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId, $datesArray['fromDate'],
                    $datesArray['toDate']) / 2.0);

        $response['countOrdersWithoutDistance'] = (float) $this->getOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainProfileId,
            $datesArray['fromDate'], $datesArray['toDate']) +
            ((float) $this->getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainProfileId,
                $datesArray['fromDate'], $datesArray['toDate']) / 2.0);

        //The amount received by the captain in cash from the orders, this amount will be handed over to the admin
        $response['amountForStore'] = $this->getUnPaidCashOrdersDuesByCaptainProfileIdAndDuringSpecificTime($captainProfileId,
            $datesArray['fromDate'], $datesArray['toDate']);

        $response['sumPayments'] = $sumPayments;

        $response['dateFinancialCycleStarts'] = $datesArray['fromDate'];

        $response['dateFinancialCycleEnds'] = $datesArray['toDate'];

        return $response;
    }

    public function getBalanceDetails(array $financialSystemDetail, int $captainProfileId, float $sumPayments, array $datesArray, int $countWorkdays): CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse
    {
        $financialSystemDetail = $this->initializeNecessaryFieldsForDuesCalculation($captainProfileId, $datesArray, $sumPayments,
            $financialSystemDetail);

        $financialSystemDetail['financialDues'] = $this->financialDuesCalculator($countWorkdays, $financialSystemDetail['countOrders'],
            $financialSystemDetail['countOrdersMaxFromNineteen'], $financialSystemDetail['compensationForEveryOrder'], $financialSystemDetail['salary']);

        $total = $financialSystemDetail['financialDues'] - $sumPayments;

        $financialSystemDetail['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;

        if ($total <= 0) {
            $financialSystemDetail['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;
        }

        $financialSystemDetail['total'] = abs($total);

        return $this->autoMapping->map('array', CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse::class,
            $financialSystemDetail);
    }
}
