<?php

namespace App\Service\Admin\CaptainFinancialSystem\CaptainFinancialSystemThree;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemThreeBalanceDetailManager;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingOnOrderBalanceDetailResponse;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemThree\CaptainFinancialSystemThreeGetStoreAmountService;

// This service responsible for preparing the details of a specific captain financial dues for admin
// Note: Financial dues according to the third financial system (according on order)
class AdminCaptainFinancialSystemThreeGetBalanceDetailsService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminCaptainFinancialSystemThreeBalanceDetailManager $adminCaptainFinancialSystemThreeBalanceDetailManager,
        private CaptainFinancialSystemThreeGetStoreAmountService $captainFinancialSystemThreeGetStoreAmountService
    )
    {
    }

    public function getOrdersDetailsByFinancialSystemThree(int $captainId, array $financialSystemThreeDetail, string $fromDate, string $toDate): array
    {
        return $this->adminCaptainFinancialSystemThreeBalanceDetailManager->getOrdersDetailsByFinancialSystemThree($captainId,
            $fromDate, $toDate, $financialSystemThreeDetail['countKilometersFrom'], $financialSystemThreeDetail['countKilometersTo']);
    }

    public function getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): int
    {
        $ordersCountResult = $this->adminCaptainFinancialSystemThreeBalanceDetailManager->getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate($captainId,
            $fromDate, $toDate);

        if (count($ordersCountResult) > 0) {
            return $ordersCountResult[0];

        }

        return 0;
    }

    public function getUnPaidCashOrdersDuesCountByCaptainAndDuringSpecificTime(int $captainId, string $fromDate, string $toDate): int
    {
        return (int) $this->captainFinancialSystemThreeGetStoreAmountService->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainId,
            $fromDate, $toDate);
    }

    public function getFinalFinancialAccount(float $sumPayments, array $financialAccountDetails, int $captainId, array $date): array
    {
        $finalFinancialAccount = [];

        $finalFinancialAccount['amountForStore'] = 0;

        $finalFinancialAccount['countOrdersWithoutDistance'] = 0;

        $finalFinancialAccount['financialDues'] = array_sum(array_map(fn ($financialAccountDetail) => $financialAccountDetail->captainTotalCategory, $financialAccountDetails));

        $finalFinancialAccount['sumPayments'] = $sumPayments;

        $total = round($sumPayments - $finalFinancialAccount['financialDues'], 2);

        $finalFinancialAccount['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;

        if ($total <= 0 ) {
            $finalFinancialAccount['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;
        }

        $finalFinancialAccount['total'] = abs($total);

        $finalFinancialAccount['countOrdersWithoutDistance'] = $this->getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);

        $finalFinancialAccount['amountForStore'] = $this->getUnPaidCashOrdersDuesCountByCaptainAndDuringSpecificTime($captainId, $date['fromDate'], $date['toDate']);

        $finalFinancialAccount['dateFinancialCycleStarts'] = $date['fromDate'];
        $finalFinancialAccount['dateFinancialCycleEnds'] = $date['toDate'];

        return $finalFinancialAccount;
    }

    /**
     * Calculate captain financial due, amount from cash orders, and the bonus if the captain achieve the goal
     * and return all the financial information to the admin
     */
    public function getBalanceDetailsForAdmin(array $financialSystemThreeDetails, int $captainId, float $sumPayments, array $date): array
    {
        $financialAccountDetails = [];

        foreach ($financialSystemThreeDetails as $financialSystemThreeDetail) {
            // Get orders with details according to the category of the financial system
            $financialSystemThreeDetail['orders'] = $this->getOrdersDetailsByFinancialSystemThree($captainId, $financialSystemThreeDetail,
                $date['fromDate'], $date['toDate']);

            // Get the number of orders according to the categories of the financial system
            $countOrders = count($financialSystemThreeDetail['orders']);

            // Calculate the cost of all orders which belong this category (basic cost without bonus)
            $financialSystemThreeDetail['captainTotalCategory'] = $countOrders * $financialSystemThreeDetail['amount'];

            // Set the completed orders count field in the response which will be returned
            $financialSystemThreeDetail['contOrderCompleted'] = $countOrders;

            // Check if the category offers bonus
            if ($financialSystemThreeDetail['bounceCountOrdersInMonth']) {
                // Calculate the remaining number of orders to get the bounce
                $financialSystemThreeDetail['countOfOrdersLeft'] = $financialSystemThreeDetail['bounceCountOrdersInMonth'] - $financialSystemThreeDetail['contOrderCompleted'];

                // Set the motivational message
                $financialSystemThreeDetail['message'] = CaptainFinancialSystem::COUNT_REMAINING_ORDER . " "
                    . $financialSystemThreeDetail['countOfOrdersLeft'] . " " . CaptainFinancialSystem::FOR_BOUNCE . " "
                    . $financialSystemThreeDetail['bounce'];

                if ($financialSystemThreeDetail['countOfOrdersLeft'] < 0) {
                    $financialSystemThreeDetail['countOfOrdersLeft'] = 0;
                }

                // Check if the captain achieved the required order to gain the bounce
                if ($financialSystemThreeDetail['contOrderCompleted'] >= $financialSystemThreeDetail['bounceCountOrdersInMonth']) {
                    $financialSystemThreeDetail['captainBounce'] = $financialSystemThreeDetail['bounce'];

                    //Amount owed to the captain with bonus
                    $financialSystemThreeDetail['captainTotalCategory'] = $financialSystemThreeDetail['bounce'] +  $financialSystemThreeDetail['captainTotalCategory'];

                    //A congratulatory message
                    $financialSystemThreeDetail['message'] = CaptainFinancialSystem::CAPTAIN_GOT_BOUNCE_ADMIN." ".$financialSystemThreeDetail['bounce'];
                }
            }

            $financialAccountDetails[] = $this->autoMapping->map('array', AdminCaptainFinancialSystemAccordingOnOrderBalanceDetailResponse::class,
                $financialSystemThreeDetail);
        }

        $finalFinancialAccount = $this->getFinalFinancialAccount($sumPayments, $financialAccountDetails, $captainId, $date);

        return [
            "financialAccountDetails" => $financialAccountDetails,
            "finalFinancialAccount" => $finalFinancialAccount
        ];
    }
}
