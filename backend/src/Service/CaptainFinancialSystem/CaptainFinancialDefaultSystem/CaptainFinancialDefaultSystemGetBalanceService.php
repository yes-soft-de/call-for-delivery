<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDefaultSystem;

class CaptainFinancialDefaultSystemGetBalanceService
{
    public function __construct()
    {
    }

    /**
     * Get array which includes:
     * basic captain financial amount (due), bonus, and amount for store
     *
     * Get today delivered (or cancelled orders) by captain:
     *     For each order:
     *          If distance limit is set:
     *              If order distance < distance limit:
     *                  financial amount +=
     */
    public function calculateCaptainDuesAndStoreCashAmountOnly(array $captainFinancialSystemDetails, int $captainProfileId, string $fromDate, string $toDate): array
    {
        $financialAccountDetails = [];

        $financialAccountDetails['basicFinancialAmount'] = 0.0;
        $financialAccountDetails['bounce'] = 0.0;
        $financialAccountDetails['amountForStore'] = 0.0;

//        $financialAccountDetails['amountForStore'] = $this->getUnPaidCashOrdersDuesByCaptainProfileIdAndDuringSpecificTime($captainProfileId,
//            $fromDate, $toDate);
//
//        $ordersCount = (float) $this->getDeliveredOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
//                $fromDate, $toDate) +
//            ((float) $this->getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates($captainProfileId, $fromDate, $toDate)
//                / CaptainFinancialSystem::CANCELLED_ORDER_DIVISION_FACTOR_CONST);



        return $financialAccountDetails;
    }
}
