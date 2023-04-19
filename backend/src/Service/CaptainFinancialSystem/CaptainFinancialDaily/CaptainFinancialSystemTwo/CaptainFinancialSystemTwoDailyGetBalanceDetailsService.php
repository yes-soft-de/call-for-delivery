<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialSystemTwo;

use App\Constant\Captain\CaptainConstant;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Service\CaptainFinancialSystem\CaptainFinancialDue\CaptainFinancialDueHandleService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwo\CaptainFinancialSystemTwoGetStoreAmountService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwo\CaptainFinancialSystemTwoOrderGetService;
use App\Service\DateFactory\DateFactoryService;

class CaptainFinancialSystemTwoDailyGetBalanceDetailsService
{
    public function __construct(
        private CaptainFinancialSystemTwoOrderGetService $captainFinancialSystemTwoOrderGetService,
        private CaptainFinancialSystemTwoGetStoreAmountService $captainFinancialSystemTwoGetStoreAmountService,
        private CaptainFinancialDueHandleService $captainFinancialDueHandleService,
        private CaptainFinancialSystemTwoDailyAmountCalculationService $captainFinancialSystemTwoDailyAmountCalculationService,
        private DateFactoryService $dateFactoryService
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
     * Get the dues of unpaid cash orders (for group of orders)
     */
    public function getUnPaidCashOrdersDueByCaptainProfileIdAndDuringSpecificTime(int $captainId, string $fromDate, string $toDate): string
    {
        return $this->captainFinancialSystemTwoGetStoreAmountService->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainId,
            $fromDate, $toDate);
    }

    /**
     * Get the start and end dates of the current active financial cycle of the captain,
     * and if not exist then creates a new financial cycle
     */
    public function getCurrentAndActiveCaptainFinancialDueStartAndEndDatesByCaptain(int $captainProfileId, \DateTime $fromDate, \DateTime $toDate): array|string
    {
        return $this->captainFinancialDueHandleService->getCurrentAndActiveCaptainFinancialDueStartAndEndDatesByCaptain($captainProfileId,
            $fromDate, $toDate);
    }

    /**
     * Calculate the financial amount of today, besides the bonus if it exists
     */
    public function calculateDailyAmountAndBonus(int $targetStatus, float $salary, float $monthCompensation, float $todayCompletedOrdersCount,
                                                 float $currentFinancialCycleCompletedOrders, int $countOrdersInMonth = null, float $bounceMaxCountOrdersInMonth = null): array
    {
        return $this->captainFinancialSystemTwoDailyAmountCalculationService->calculateDailyAmountAndBonus($targetStatus,
            $salary, $monthCompensation, $todayCompletedOrdersCount, $currentFinancialCycleCompletedOrders,
            $countOrdersInMonth, $bounceMaxCountOrdersInMonth);
    }

    /**
     * Converts a string date to a DateTime object, and return it with another 30-days date
     */
    public function getDateTimeObjectOfStringObjectPlusThirtyDays(string $stringDate): array
    {
        return $this->dateFactoryService->getDateTimeObjectOfStringObjectPlusThirtyDays($stringDate);
    }

    /**
     * Check if captain accomplish the target of the financial system, or not, or beyond
     */
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

    /**
     * orders count = (delivered orders count + (cancelled orders count / 2)) +
     * (overdue 19 kilo orders count + (cancelled overdue 19 kilo orders count / 2))
     */
    public function getDeliveredAndCancelledAndOverdueOrdersCount(int $captainProfileId, string $fromDate, string $toDate): float|int
    {
        return ((float) $this->getDeliveredOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId, $fromDate, $toDate)
                +
                ((float) $this->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId, $fromDate, $toDate)
                    / CaptainFinancialSystem::CANCELLED_ORDER_DIVISION_FACTOR_CONST))

            + ((float) $this->getOverdueDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId, $fromDate, $toDate)
                +
                ((float) $this->getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId, $fromDate, $toDate)
                    / CaptainFinancialSystem::CANCELLED_ORDER_DIVISION_FACTOR_CONST));
    }

    /**
     * Get array which includes:
     * basic captain financial amount (due), bonus, and amount for store
     */
    public function calculateCaptainDuesAndStoreCashAmountOnly(array $captainFinancialSystemDetail, int $captainProfileId, string $fromDate, string $toDate): array
    {
        $financialAccountDetails = [];

        $financialAccountDetails['basicFinancialAmount'] = 0.0;
        $financialAccountDetails['bounce'] = 0.0;
        $financialAccountDetails['amountForStore'] = 0.0;

        $financialAccountDetails['amountForStore'] = $this->getUnPaidCashOrdersDueByCaptainProfileIdAndDuringSpecificTime($captainProfileId,
            $fromDate, $toDate);

        // Get the start date and end date of current active financial cycle of the captain
        // note: if there is no current and active financial cycle, then we gonna create a new one starting form
        // the date of the order creation
        $startAndEndDatesArrayResult = $this->getDateTimeObjectOfStringObjectPlusThirtyDays($fromDate);

        $financialCycleStartAndEndDatesArrayResult = $this->getCurrentAndActiveCaptainFinancialDueStartAndEndDatesByCaptain($captainProfileId,
            $startAndEndDatesArrayResult[0], $startAndEndDatesArrayResult[1]);

        if ($financialCycleStartAndEndDatesArrayResult === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return $financialAccountDetails;
        }

        // Get the count of orders today
        $todayOrdersCount = (float) $this->getDeliveredAndCancelledAndOverdueOrdersCount($captainProfileId, $fromDate, $toDate);

        // Get the count of orders during current financial cycle
        $currentFinancialCycleOrdersCount = (float) $this->getDeliveredAndCancelledAndOverdueOrdersCount($captainProfileId,
            $financialCycleStartAndEndDatesArrayResult[0]->format('y-m-d 00:00:00'), $financialCycleStartAndEndDatesArrayResult[1]->format('y-m-d 23:59:59'));

        // Check if the captain achieve the target of the financial system
        $checkTarget = $this->checkAchievedFinancialSystemTarget($captainFinancialSystemDetail['countOrdersInMonth'], $currentFinancialCycleOrdersCount);

        // Calculate the financial due according to the target state
        $dailyFinancialAmountAndBonusArrayResult = $this->calculateDailyAmountAndBonus($checkTarget, $captainFinancialSystemDetail['salary'],
            $captainFinancialSystemDetail['monthCompensation'], $todayOrdersCount, $currentFinancialCycleOrdersCount,
            $captainFinancialSystemDetail['countOrdersInMonth'], $captainFinancialSystemDetail['bounceMaxCountOrdersInMonth']);

        // ---- Store each field in its related place ----
        $financialAccountDetails['basicFinancialAmount'] = $dailyFinancialAmountAndBonusArrayResult[0];
        $financialAccountDetails['bounce'] = $dailyFinancialAmountAndBonusArrayResult[1];

        return $financialAccountDetails;
    }
}
