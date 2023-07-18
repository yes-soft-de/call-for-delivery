<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDefaultSystem;

use App\Service\CaptainFinancialSystem\CaptainFinancialDefaultSystem\CaptainFinancialDefaultSystemGetStoreAmountService;
use App\Service\CaptainFinancialSystem\CaptainFinancialDefaultSystem\CaptainFinancialDefaultSystemOrderGetService;

class CaptainFinancialDefaultSystemDailyGetBalanceDetailsService
{
    public function __construct(
        private CaptainFinancialDefaultSystemOrderGetService $captainFinancialDefaultSystemOrderGetService,
        private CaptainFinancialDefaultSystemGetStoreAmountService $captainFinancialDefaultSystemGetStoreAmountService
    )
    {
    }

    /**
     * Get the dues of unpaid cash orders (for group of orders)
     */
    public function getUnPaidCashOrdersDueByCaptainProfileIdAndDuringSpecificTime(int $captainId, string $fromDate, string $toDate): string
    {
        return $this->captainFinancialDefaultSystemGetStoreAmountService->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainId,
            $fromDate, $toDate);
    }

    /**
     * Get the count of delivered orders by specific captain and among specific date
     */
    public function getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialDefaultSystemOrderGetService->getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);

//        if (count($ordersCountResult) > 0) {
//            return $ordersCountResult[0];
//        }
//
//        return 0;
    }

//    /**
//     * Get the count of cancelled orders and related to a specific captain and among specific date
//     */
//    public function getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): int
//    {
//        $countOrdersResult = $this->captainFinancialDefaultSystemOrderGetService->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
//            $fromDate, $toDate);
//
//        if (count($countOrdersResult) > 0) {
//            return $countOrdersResult[0];
//        }
//
//        return 0;
//    }

//    /**
//     * orders count = (delivered orders count + (cancelled orders count / 2))
//     */
//    public function getDeliveredAndCancelledAndOverdueOrdersCount(int $captainProfileId, string $fromDate, string $toDate): float|int
//    {
//        return ((float) $this->getDeliveredOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId, $fromDate, $toDate)
//                +
//                ((float) $this->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId, $fromDate, $toDate)
//                    / CaptainFinancialSystem::CANCELLED_ORDER_DIVISION_FACTOR_CONST));
//    }

    /**
     * Get array which includes:
     * basic captain financial amount (due), bonus, and amount for store
     *
     * Get today delivered (or cancelled orders) by captain:
     *     For each order:
     *          if order distance <= 5 k
     *              financial amount += (10 + 2.5)
     *
     *          else if order distance >= 6 AND order distance < 9
     *              financial amount += (10 + (0.5 * order distance))
     *
     *          else if order distance >= 9
     *              financial amount += (10 + (0.75 * order distance))
     *
     * financial amount = financial amount - amount for store (which remains with the captain)
     */
    public function calculateCaptainDuesAndStoreCashAmountOnly(array $captainFinancialSystemDetails, int $captainProfileId, string $fromDate, string $toDate): array
    {
        $financialAccountDetails = [];

        $financialAccountDetails['basicFinancialAmount'] = 0.0;
        $financialAccountDetails['bounce'] = 0.0;
        $financialAccountDetails['amountForStore'] = 0.0;

        $financialAccountDetails['amountForStore'] = $this->getUnPaidCashOrdersDueByCaptainProfileIdAndDuringSpecificTime($captainProfileId,
            $fromDate, $toDate);

        $orders = $this->getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId, $fromDate, $toDate);

        if (count($orders) > 0) {
            foreach ($orders as $order) {
                $financialAccountDetails['basicFinancialAmount'] += $captainFinancialSystemDetails['openingOrderCost'];

                $distance = $order['storeBranchToClientDistance'];

                if ($distance) {
                    if ($distance <= $captainFinancialSystemDetails['firstSliceLimit']) {
                        $financialAccountDetails['basicFinancialAmount'] += $captainFinancialSystemDetails['firstSliceCost'];

                    } elseif (($distance >= $captainFinancialSystemDetails['secondSliceFromLimit'])
                        && ($distance < $captainFinancialSystemDetails['secondSliceToLimit'])) {
                        $financialAccountDetails['basicFinancialAmount'] += ($distance * $captainFinancialSystemDetails['secondSliceOneKilometerCost']);

                    } elseif ($distance >= $captainFinancialSystemDetails['thirdSliceFromLimit']) {
                        $financialAccountDetails['basicFinancialAmount'] += ($distance * $captainFinancialSystemDetails['thirdSliceOneKilometerCost']);

                    }
                }
            }
        }

        return $financialAccountDetails;
    }
}
