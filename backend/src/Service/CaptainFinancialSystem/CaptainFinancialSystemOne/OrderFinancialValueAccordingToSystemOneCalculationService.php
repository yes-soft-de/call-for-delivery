<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemOne;

use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;

class OrderFinancialValueAccordingToSystemOneCalculationService
{
    // Calculate the expected financial value of an order and return it
    // First, check order distance:
    //      if order distance <= 19:
    //          order value = compensation for every order (Note: captain will get salary either if he/she delivered order or not)
    //      else if order distance > 19:
    //          order value = 2 * (compensation for every order)
    public function getOrderFinancialValueAccordingOnCountOfHours(float $compensationForEveryOrder, float $orderDistance = null): float
    {
        if ($orderDistance) {
            if ($orderDistance <= CaptainFinancialSystem::KILOMETER_TO_DOUBLE_ORDER) {
                return $compensationForEveryOrder;

            } elseif ($orderDistance > CaptainFinancialSystem::KILOMETER_TO_DOUBLE_ORDER) {
                return round(($compensationForEveryOrder * 2), 1);
            }
        }

        return 0.0;
    }
}
