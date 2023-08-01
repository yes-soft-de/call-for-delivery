<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDefaultSystem;

class OrderFinancialValueAccordingToDefaultSystemCalculationService
{
    public function __construct(
    )
    {
    }

    /**
     * If order distance = null => return 0
     * Else:
     *      if order distance <= 5 k
     *              financial amount += (10 + 2.5)
     *
     *      else if order distance >= 6 AND order distance < 9
     *         financial amount += (10 + (0.5 * order distance))
     *
     *      else if order distance >= 9
     *         financial amount += (10 + (0.75 * order distance))
     */
    public function getOrderFinancialValueAccordingToDefaultFinancialSystem(array $captainFinancialSystemDetails, ?float $orderDistance = null): float
    {
        $financialAmount = 0.0;

        if ($orderDistance !== null) {
            $financialAmount += $captainFinancialSystemDetails['openingOrderCost'];

            if ($orderDistance <= $captainFinancialSystemDetails['firstSliceLimit']) {
                $financialAmount += $captainFinancialSystemDetails['firstSliceCost'];

            } elseif (($orderDistance >= $captainFinancialSystemDetails['secondSliceFromLimit'])
                && ($orderDistance < $captainFinancialSystemDetails['secondSliceToLimit'])) {
                $financialAmount += ($orderDistance * $captainFinancialSystemDetails['secondSliceOneKilometerCost']);

            } elseif ($orderDistance >= $captainFinancialSystemDetails['thirdSliceFromLimit']) {
                $financialAmount += ($orderDistance * $captainFinancialSystemDetails['thirdSliceOneKilometerCost']);
            }
        }

        return round($financialAmount, 1);
    }
}
