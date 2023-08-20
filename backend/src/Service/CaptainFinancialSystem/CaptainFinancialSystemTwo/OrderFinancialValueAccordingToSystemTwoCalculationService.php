<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwo;

use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Service\CaptainFinancialSystem\CaptainFinancialDue\CaptainFinancialDueGetService;
use App\Service\CaptainFinancialSystemDate\CaptainFinancialSystemDateService;

class OrderFinancialValueAccordingToSystemTwoCalculationService
{
    private CaptainFinancialSystemTwoGetService $captainFinancialSystemTwoGetService;
    private CaptainFinancialDueGetService $captainFinancialDueGetService;
    private CaptainFinancialSystemDateService $captainFinancialSystemDateService;

    public function __construct(CaptainFinancialSystemTwoGetService $captainFinancialSystemTwoGetService, CaptainFinancialDueGetService $captainFinancialDueGetService,
                                CaptainFinancialSystemDateService $captainFinancialSystemDateService)
    {
        $this->captainFinancialSystemTwoGetService = $captainFinancialSystemTwoGetService;
        $this->captainFinancialDueGetService = $captainFinancialDueGetService;
        $this->captainFinancialSystemDateService = $captainFinancialSystemDateService;
    }

    // Calculate the expected financial value of an order and return it
    // First, get the captain financial system type and id
    //  Depending on financial system type and id, calculate the expected financial value of the order
    //      If captain financial system is the second one
    //          Check order distance to consider it as a single or double order
    //          If distance <= 19 K
    //              Get the captain target
    //              If target not achieved currently
    //                  order value = 10 * (month compensation / orders in month)
    //              If target achieved currently
    //                  order value = 25 * (month compensation / orders in month)
    //          If distance > 19 K
    //              Get the captain target
    //              If target not achieved currently
    //                  order value = (10 * (month compensation / orders in month)) * 2
    //              If target achieved currently
    //                  order value = (25 * (month compensation / orders in month)) * 2
    public function getOrderFinancialValueAccordingToCountOfOrders(int $captainProfileId, array $captainFinancialSystemDetails, float $orderDistance = null): float
    {
        // Captain financial system is the second one
        if (! $orderDistance) {
            return 0.0;
        }

        $dates = $this->getLatestCaptainFinancialDuesStartAndEndDates($captainProfileId);

        $ordersCount = $this->getDeliveredOrdersCountByCaptainIdAndBetweenTwoDates($captainProfileId, $dates['fromDate'], $dates['toDate']);

        $target = $this->checkTarget($captainFinancialSystemDetails['countOrdersInMonth'], $ordersCount);

        // Check order distance to consider it as a single or double order
        if ($orderDistance <= CaptainFinancialSystem::KILOMETER_TO_DOUBLE_ORDER) {
            // Get the captain target
            if ($target === CaptainFinancialSystem::TARGET_FAILED_INT) {
                // Target not achieved currently
                // order value = bounceMinCountOrdersInMonth * (month compensation / orders in month) >>> Rami's Equation
                // order value = (salary + monthCompensation) / countOrdersInMonth
                return round(
                    (($captainFinancialSystemDetails['salary'] + $captainFinancialSystemDetails['monthCompensation']) /
                        (float) $captainFinancialSystemDetails['countOrdersInMonth']),
                    1);

            } elseif (($target === CaptainFinancialSystem::TARGET_SUCCESS_INT) || ($target === CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE_INT)) {
                // Target achieved currently
                // order value = bounceMaxCountOrdersInMonth * (month compensation / orders in month) >>> Rami's Equation
                // order value = (salary + monthCompensation) / countOrdersInMonth
                return round(
                    (($captainFinancialSystemDetails['salary'] + $captainFinancialSystemDetails['monthCompensation']) /
                        (float) $captainFinancialSystemDetails['countOrdersInMonth']),
                    1);
            }

        } elseif ($orderDistance > CaptainFinancialSystem::KILOMETER_TO_DOUBLE_ORDER) {
            // Get the captain target
            if ($target === CaptainFinancialSystem::TARGET_FAILED_INT) {
                // Target not achieved currently
                // order value = (bounceMinCountOrdersInMonth * (month compensation / orders in month)) * 2 >>> Rami's Equation
                // order value = ((salary + monthCompensation) / countOrdersInMonth) * 2
                return round(((($captainFinancialSystemDetails['salary'] + $captainFinancialSystemDetails['monthCompensation']) /
                        (float) $captainFinancialSystemDetails['countOrdersInMonth'])) * 2.0, 1);

            } elseif (($target === CaptainFinancialSystem::TARGET_SUCCESS_INT) || ($target === CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE_INT)) {
                // Target achieved currently
                // order value = (bounceMaxCountOrdersInMonth * (month compensation / orders in month)) * 2 >>> Rami's Equation
                // order value = ((salary + monthCompensation) / countOrdersInMonth) * 2
                return round(((($captainFinancialSystemDetails['salary'] + $captainFinancialSystemDetails['monthCompensation']) /
                        (float) $captainFinancialSystemDetails['countOrdersInMonth'])) * 2.0, 1);
            }
        }

        return 0.0;
    }

    public function checkTarget(int $countOrdersInMonth, int $countOrdersCompleted): int
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

    public function getDeliveredOrdersCountByCaptainIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): int
    {
        // Get the count of delivered orders by specific captain and between two dates
        $ordersCountResult = $this->captainFinancialSystemTwoGetService->getDeliveredOrdersCountByCaptainIdAndBetweenTwoDates($captainId,
            $fromDate, $toDate);

        // Get delivered orders of the captain between two dates and which overdue the 19 Kilometer
        $overdueOrdersResult = $this->captainFinancialSystemTwoGetService->getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates($captainId,
            $fromDate, $toDate);

        if (count($ordersCountResult) > 0) {
            if (count($overdueOrdersResult) > 0) {
                return ((int) $overdueOrdersResult[0] + (int) $ordersCountResult[0]);

            } else {
                return ((int) $ordersCountResult[0]);
            }

        } else {
            if (count($overdueOrdersResult) > 0) {
                return ((int) $overdueOrdersResult[0]);

            } else {
                return 0;
            }
        }
    }

    public function getLatestCaptainFinancialDues(int $captainProfileId): ?array
    {
        return $this->captainFinancialDueGetService->getLatestCaptainFinancialDues($captainProfileId);
    }

    public function getLatestCaptainFinancialDuesStartAndEndDates(int $captainProfileId): array
    {
        $captainFinancialDues = $this->getLatestCaptainFinancialDues($captainProfileId);

        if ($captainFinancialDues) {
            return ["fromDate" => $captainFinancialDues['startDate']->format('Y-m-d 00:00:00'), "toDate" => $captainFinancialDues['endDate']->format('y-m-d 23:59:59')];

        } else {
            return $this->captainFinancialSystemDateService->getStartAndEndDatesOfTodayInStringFormat();
        }
    }
}
