<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialSystemTwo;

use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;

/**
 * Responsible for only calculating the daily financial amount according to the second financial system
 */
class CaptainFinancialSystemTwoDailyAmountCalculationService
{
    public function __construct()
    {
    }

    /**
     * Calculate the financial amount of today, besides the bonus if it exists
     */
    public function calculateDailyAmountAndBonus(int $targetStatus, float $salary, float $monthCompensation, float $todayCompletedOrdersCount,
                                           float $currentFinancialCycleCompletedOrders, int $countOrdersInMonth = null, float $bounceMaxCountOrdersInMonth = null): array
    {
        $financialDues = 0.0;
        $bonus = 0.0;

        // Calculate the financial dues according to the achieved target
        if ($targetStatus === CaptainFinancialSystem::TARGET_FAILED_INT
            || $targetStatus === CaptainFinancialSystem::TARGET_SUCCESS_INT) {
            // financial amount of today = today completed orders * (($salary + month compensation) / count Orders In Month)
            // Captain will get 1900/150 * completed orders = 12.67 * completed orders
            $financialDues = $todayCompletedOrdersCount * (($salary + $monthCompensation) / (float) $countOrdersInMonth);

        } elseif ($targetStatus === CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE_INT) {
            // Captain will get the salary + month compensation + (25 for each order overdue the required orders in month)
            $financialDues = $todayCompletedOrdersCount * (($salary + $monthCompensation) / (float) $countOrdersInMonth);
            $bonus = ($currentFinancialCycleCompletedOrders - $countOrdersInMonth) * $bounceMaxCountOrdersInMonth;
        }

        return [round($financialDues, 2), $bonus];
    }
}
