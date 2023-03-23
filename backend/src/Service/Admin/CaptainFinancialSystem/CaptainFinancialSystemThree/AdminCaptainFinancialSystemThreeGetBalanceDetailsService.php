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

    /**
     * Get count of orders without distance and cancelled by store and related to specific captain during specific time
     */
    public function getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate(int $captainProfileId, string $fromDate, string $toDate): int
    {
        $ordersCountResult = $this->adminCaptainFinancialSystemThreeBalanceDetailManager->getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainProfileId,
            $fromDate, $toDate);

        if (count($ordersCountResult) > 0) {
            return $ordersCountResult[0];
        }

        return 0;
    }

    /**
     * Get cancelled orders, by store at 'in store' state, count according to specific captain and dates
     */
    public function getCancelledOrdersCountByCaptainProfileIdAndSpecificDateAndSpecificDistanceRange(int $captainProfileId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): int
    {
        $ordersCountResult = $this->adminCaptainFinancialSystemThreeBalanceDetailManager->getCancelledOrdersCountByCaptainProfileIdAndSpecificDateAndSpecificDistanceRange($captainProfileId,
            $fromDate, $toDate, $countKilometersFrom, $countKilometersTo);

        if ($ordersCountResult) {
            if (count($ordersCountResult) > 0) {
                return $ordersCountResult['countOrder'];
            }
        }

        return 0;
    }

    public function getDeliveredOrdersCountByCaptainProfileIdAndSpecificDateAndDistanceRange(int $captainProfileId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): int
    {
        $ordersCountResult = $this->adminCaptainFinancialSystemThreeBalanceDetailManager->getCountOrdersByFinancialSystemThree($captainProfileId,
            $fromDate, $toDate, $countKilometersFrom, $countKilometersTo);

        if ($ordersCountResult) {
            if (count($ordersCountResult) > 0) {
                return $ordersCountResult['countOrder'];
            }
        }

        return 0;
    }

    public function getFinalFinancialAccount(float $sumPayments, array $financialAccountDetails, int $captainId, array $date): array
    {
        $finalFinancialAccount = [];

        $finalFinancialAccount['amountForStore'] = 0;

        $finalFinancialAccount['countOrdersWithoutDistance'] = 0;

        $finalFinancialAccount['financialDues'] = array_sum(array_map(fn ($financialAccountDetail) => $financialAccountDetail->captainTotalCategory, $financialAccountDetails));

        $finalFinancialAccount['sumPayments'] = $sumPayments;

        $total = round($sumPayments - $finalFinancialAccount['financialDues'], 2);

        $finalFinancialAccount['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_BALANCE_CONST;

        if ($total <= 0) {
            $finalFinancialAccount['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_EXIST_CONST;
        }

        $finalFinancialAccount['total'] = abs($total);

        $finalFinancialAccount['countOrdersWithoutDistance'] = ((float) $this->getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate($captainId,
            $date['fromDate'], $date['toDate'])) +
            ((float) $this->getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate($captainId,
                $date['fromDate'], $date['toDate']) / CaptainFinancialSystem::CANCELLED_ORDER_DIVISION_FACTOR_CONST);

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
            $financialSystemThreeDetail['contOrderCompleted'] = ((float) $this->getDeliveredOrdersCountByCaptainProfileIdAndSpecificDateAndDistanceRange($captainId, $date['fromDate'],
                    $date['toDate'], $financialSystemThreeDetail['countKilometersFrom'], $financialSystemThreeDetail['countKilometersTo']))
                +
                ((float) $this->getCancelledOrdersCountByCaptainProfileIdAndSpecificDateAndSpecificDistanceRange($captainId, $date['fromDate'],
                    $date['toDate'], $financialSystemThreeDetail['countKilometersFrom'], $financialSystemThreeDetail['countKilometersTo'])
                    / CaptainFinancialSystem::CANCELLED_ORDER_DIVISION_FACTOR_CONST);

            // Calculate the cost of all orders which belong this category (basic cost without bonus)
            $financialSystemThreeDetail['captainTotalCategory'] = $financialSystemThreeDetail['contOrderCompleted']
                * (float) $financialSystemThreeDetail['amount'];

            // Check if the category offers bonus
            if ($financialSystemThreeDetail['bounceCountOrdersInMonth']) {
                // Calculate the remaining number of orders to get the bounce
                $financialSystemThreeDetail['countOfOrdersLeft'] = (float) $financialSystemThreeDetail['bounceCountOrdersInMonth'] -
                    $financialSystemThreeDetail['contOrderCompleted'];

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
                    $financialSystemThreeDetail['captainTotalCategory'] = $financialSystemThreeDetail['bounce']
                        + $financialSystemThreeDetail['captainTotalCategory'];

                    //A congratulatory message
                    $financialSystemThreeDetail['message'] = CaptainFinancialSystem::CAPTAIN_GOT_BOUNCE_ADMIN
                        ." ".$financialSystemThreeDetail['bounce'];
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
