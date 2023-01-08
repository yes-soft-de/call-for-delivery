<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwo;

use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;

// This service responsible for only the core calculation of the dues

class CaptainFinancialSystemTwoCalculationService
{
    public function __construct()
    {

    }

    public function calculateFinancialDues(int $targetStatus, float $salary, float $monthCompensation, int $countOrdersCompleted = null,
                                           int $countOrdersInMonth = null, float $bounceMaxCountOrdersInMonth = null): float
    {
        $financialDues = 0.0;

        // Calculate the financial dues according to the achieved target
        if ($targetStatus === CaptainFinancialSystem::TARGET_SUCCESS_INT) {
            // captain will get the salary + month compensation
            $financialDues = $salary + $monthCompensation;

        } elseif ($targetStatus === CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE_INT) {
            // Captain will get the salary + month compensation + (25 for each order overdue 19 Kilo)
            $financialDues = $salary + $monthCompensation + (($countOrdersCompleted - $countOrdersInMonth) * $bounceMaxCountOrdersInMonth);

        } elseif ($targetStatus === CaptainFinancialSystem::TARGET_FAILED_INT) {
            // Captain will get 1900/150 * completed orders = 12.67 * completed orders
            $financialDues = $countOrdersCompleted * (($salary + $monthCompensation) / (float) $countOrdersInMonth);
        }

        return round($financialDues, 2);
    }
}
