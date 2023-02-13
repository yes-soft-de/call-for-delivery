<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemThree;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingOnOrderBalanceDetailResponse;
use App\Service\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersService;

// This service responsible for preparing the details of a specific captain financial dues
// Note: Financial dues according to the third financial system (according on order)
class CaptainFinancialSystemThreeGetBalanceDetailsService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private CaptainFinancialSystemThreeOrderGetService $captainFinancialSystemThreeOrderGetService,
        private StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService
    )
    {
    }

    public function getCountOrdersByFinancialSystemThree(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): ?array
    {
        return $this->captainFinancialSystemThreeOrderGetService->getCountOrdersByFinancialSystemThree($captainId, $fromDate, $toDate, $countKilometersFrom,
            $countKilometersTo);
    }

    /**
     * Get the dues of unpaid cash orders (for group of orders) by specific captain and date
     */
    public function getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime(int $captainId, string $fromDate, string $toDate): int
    {
        return (int) $this->storeOwnerDuesFromCashOrdersService->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainId, $fromDate, $toDate);
    }

    /**
     * Get count of orders without distance and delivered by specific captain during specific time
     */
    public function getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): int
    {
        return $this->captainFinancialSystemThreeOrderGetService->getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    public function getFinalFinancialAccount(float $sumPayments, array $financialAccountDetails, int $captainId, array $date): array
    {
        $finalFinancialAccount = [];

        $finalFinancialAccount['amountForStore'] = 0;
        $finalFinancialAccount['countOrdersWithoutDistance'] = 0;

        $finalFinancialAccount['financialDues'] = array_sum(array_map(fn ($financialAccountDetail) => $financialAccountDetail->captainTotalCategory, $financialAccountDetails));

        $finalFinancialAccount['sumPayments'] = $sumPayments;

        $total = $finalFinancialAccount['financialDues'] - $sumPayments;

        $finalFinancialAccount['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;

        if ($total <= 0 ) {
            $finalFinancialAccount['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;
        }

        $finalFinancialAccount['total'] = abs($total);

        $finalFinancialAccount['countOrdersWithoutDistance'] = $this->getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate($captainId,
            $date['fromDate'], $date['toDate']);

        $finalFinancialAccount['amountForStore'] = $this->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainId,
            $date['fromDate'], $date['toDate']);

        $finalFinancialAccount['dateFinancialCycleStarts'] = $date['fromDate'];
        $finalFinancialAccount['dateFinancialCycleEnds'] = $date['toDate'];

        return $finalFinancialAccount;
    }

    public function getBalanceDetails(array $financialSystemThreeDetails, int $captainId, float $sumPayments, array $date) : array
    {
        $financialAccountDetails = [];

        foreach ($financialSystemThreeDetails as $financialSystemThreeDetail) {
            // Get the number of orders arranged according to the categories of the financial system
            $countOrders = $this->getCountOrdersByFinancialSystemThree($captainId, $date['fromDate'],
                $date['toDate'], $financialSystemThreeDetail['countKilometersFrom'], $financialSystemThreeDetail['countKilometersTo']);

            // Calculate basic orders cost without bonus: total cost = order count * amount
            $financialSystemThreeDetail['captainTotalCategory'] = $countOrders['countOrder'] * $financialSystemThreeDetail['amount'];

            // Set completed orders
            $financialSystemThreeDetail['contOrderCompleted'] = $countOrders['countOrder'];

            // Check if the category offers bonus
            if ($financialSystemThreeDetail['bounceCountOrdersInMonth']) {
                //Find the remaining number of orders to get the bounce
                $financialSystemThreeDetail['countOfOrdersLeft'] = $financialSystemThreeDetail['bounceCountOrdersInMonth'] - $financialSystemThreeDetail['contOrderCompleted'];

                // Initialize motivational message
                $financialSystemThreeDetail['message'] = CaptainFinancialSystem::COUNT_REMAINING_ORDER ." "
                    .$financialSystemThreeDetail['countOfOrdersLeft']." ".CaptainFinancialSystem::FOR_BOUNCE." "
                    .$financialSystemThreeDetail['bounce'];

                if ($financialSystemThreeDetail['countOfOrdersLeft'] < 0 ) {
                    $financialSystemThreeDetail['countOfOrdersLeft'] = 0;
                }

                // Check if the captain achieve the required orders to gain the bonus
                if ($financialSystemThreeDetail['contOrderCompleted'] >= $financialSystemThreeDetail['bounceCountOrdersInMonth']) {
                    $financialSystemThreeDetail['captainBounce'] = $financialSystemThreeDetail['bounce'];
                    // Add the bonus to the total amount owed by the captain
                    $financialSystemThreeDetail['captainTotalCategory'] = $financialSystemThreeDetail['bounce'] + $financialSystemThreeDetail['captainTotalCategory'];
                    // Set congratulation message
                    $financialSystemThreeDetail['message'] = CaptainFinancialSystem::CONGRATULATIONS_CAPTAIN." ".$financialSystemThreeDetail['bounce'];
                }
            }

            $financialAccountDetails[] = $this->autoMapping->map('array', CaptainFinancialSystemAccordingOnOrderBalanceDetailResponse::class,  $financialSystemThreeDetail);
        }

        $finalFinancialAccount = $this->getFinalFinancialAccount($sumPayments, $financialAccountDetails, $captainId, $date);

        return [
            "financialAccountDetails" => $financialAccountDetails,
            "finalFinancialAccount" => $finalFinancialAccount
        ];
    }

    public function calculateCaptainDues(array $financialSystemThreeDetails, int $captainId, array $date) : array
    {
        $financialAccountDetails = [];

        foreach ($financialSystemThreeDetails as $financialSystemThreeDetail) {
            // Get the number of orders arranged according to the categories of the financial system
            $countOrders = $this->getCountOrdersByFinancialSystemThree($captainId, $date['fromDate'], $date['toDate'],
                $financialSystemThreeDetail['countKilometersFrom'], $financialSystemThreeDetail['countKilometersTo']);

            // Calculate basic orders cost without bonus: total cost = order count * amount
            $financialSystemThreeDetail['captainTotalCategory'] = $countOrders['countOrder'] * $financialSystemThreeDetail['amount'];

            // Set completed orders
            $financialSystemThreeDetail['contOrderCompleted'] = $countOrders['countOrder'];

            // Check if the captain achieve the required orders to gain the bonus
            if ($financialSystemThreeDetail['bounceCountOrdersInMonth']) {
                //Remaining number of orders to get the bounce
                $financialSystemThreeDetail['countOfOrdersLeft'] = $financialSystemThreeDetail['bounceCountOrdersInMonth'] - $financialSystemThreeDetail['contOrderCompleted'] ;

                //If the captain's achieve the order number of orders to get the bounce
                if ($financialSystemThreeDetail['contOrderCompleted'] >= $financialSystemThreeDetail['bounceCountOrdersInMonth']) {
                    $financialSystemThreeDetail['captainBounce'] = $financialSystemThreeDetail['bounce'];
                    // Add the bonus to the total amount owed by the captain
                    $financialSystemThreeDetail['captainTotalCategory'] = $financialSystemThreeDetail['bounce'] +  $financialSystemThreeDetail['captainTotalCategory'];
                }
            }

            $financialAccountDetails[] = $financialSystemThreeDetail;
        }

        return $this->getFinancialDues($financialAccountDetails, $captainId, $date);
    }

    public function getFinancialDues(array $financialAccountDetails, int $captainId, array $date): array
    {
        $finalFinancialAccount = [];

        $finalFinancialAccount['amountForStore'] = 0;

        $finalFinancialAccount['financialDues'] = array_sum(array_map(fn ($financialAccountDetail) => $financialAccountDetail['captainTotalCategory'], $financialAccountDetails));

        $finalFinancialAccount['amountForStore'] = $this->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainId,
            $date['fromDate'], $date['toDate']);

        return $finalFinancialAccount;
    }
}
