<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialSystemThree;

use App\Constant\Captain\CaptainConstant;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Service\CaptainFinancialSystem\CaptainFinancialDue\CaptainFinancialDueHandleService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemThree\CaptainFinancialSystemThreeOrderGetService;
use App\Service\DateFactory\DateFactoryService;
use App\Service\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersService;

class CaptainFinancialSystemThreeDailyGetBalanceDetailsService
{
    public function __construct(
        private CaptainFinancialSystemThreeOrderGetService $captainFinancialSystemThreeOrderGetService,
        private CaptainFinancialDueHandleService $captainFinancialDueHandleService,
        private StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService,
        private DateFactoryService $dateFactoryService
    )
    {
    }

    /**
     * Converts a string date to a DateTime object, and return it with another 30-days date
     */
    public function getDateTimeObjectOfStringObjectPlusThirtyDays(string $stringDate): array
    {
        return $this->dateFactoryService->getDateTimeObjectOfStringObjectPlusThirtyDays($stringDate);
    }

    /**
     * Gets delivered orders count according to a specific captain, a specific range of date, and a specific kilometer limits
     */
    public function getCountOrdersByFinancialSystemThree(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): int
    {
        $result = $this->captainFinancialSystemThreeOrderGetService->getCountOrdersByFinancialSystemThree($captainId,
            $fromDate, $toDate, $countKilometersFrom, $countKilometersTo);

        if ($result) {
            if (count($result) > 0) {
                return $result['countOrder'];
            }
        }

        return 0;
    }

    /**
     * Gets cancelled orders count according to a specific captain, a specific range of date, and a specific kilometer limits
     */
    public function getCancelledOrdersCountByCaptainProfileIdAndSpecificDateAndSpecificDistanceRange(int $captainProfileId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): int
    {
        $result = $this->captainFinancialSystemThreeOrderGetService->getCancelledOrdersCountByCaptainProfileIdAndSpecificDateAndSpecificDistanceRange($captainProfileId,
            $fromDate, $toDate, $countKilometersFrom, $countKilometersTo);

        if ($result) {
            if (count($result) > 0) {
                return $result['countOrder'];
            }
        }

        return 0;
    }

    /**
     * Get the start and end dates of the current active financial cycle of the captain,
     * and if not exist then creates a new financial cycle
     */
    public function getCurrentAndActiveCaptainFinancialDueStartAndEndDatesByCaptainProfileId(int $captainProfileId, \DateTime $fromDate, \DateTime $toDate): array|string
    {
        return $this->captainFinancialDueHandleService->getCurrentAndActiveCaptainFinancialDueStartAndEndDatesByCaptainProfileId($captainProfileId,
            $fromDate, $toDate);
    }

    /**
     * Get the dues of unpaid cash orders (for group of orders) by specific captain and date
     */
    public function getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime(int $captainId, string $fromDate, string $toDate): int
    {
        return (int) $this->storeOwnerDuesFromCashOrdersService->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainId,
            $fromDate, $toDate);
    }

    /**
     * orders count = (delivered orders count + (cancelled orders count / 2)) +
     * (overdue 19 kilo orders count + (cancelled overdue 19 kilo orders count / 2))
     */
    public function getDeliveredAndCancelledOrdersCountByCaptainProfileIdAndKilometerLimits(int $captainProfileId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): float|int
    {
        return ((float) $this->getCountOrdersByFinancialSystemThree($captainProfileId, $fromDate, $toDate, $countKilometersFrom,
                $countKilometersTo))
            + (((float) $this->getCancelledOrdersCountByCaptainProfileIdAndSpecificDateAndSpecificDistanceRange($captainProfileId,
                    $fromDate, $toDate, $countKilometersFrom, $countKilometersTo)) / CaptainFinancialSystem::CANCELLED_ORDER_DIVISION_FACTOR_CONST);
    }

    /**
     * Gets an array which include:
     * the basic financial amount of today
     * the bonus (according to the current financial cycle) (if exists)
     * and the cash amount for the store
     */
    public function calculateCaptainDuesAndStoreCashAmountOnly(array $financialSystemThreeDetails, int $captainId, string $fromDate, string $toDate): array
    {
        $financialAccountDetails = [];

        $financialAccountDetails['basicFinancialAmount'] = 0.0;
        $financialAccountDetails['bounce'] = 0.0;
        $financialAccountDetails['amountForStore'] = 0.0;

        $financialAccountDetails['amountForStore'] = $this->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainId,
            $fromDate, $toDate);

        // Get the start date and end date of current active financial cycle of the captain
        // note: if there is no current and active financial cycle, then we gonna create a new one starting form
        // the date of the order creation
        $startAndEndDatesArrayResult = $this->getDateTimeObjectOfStringObjectPlusThirtyDays($fromDate);

        $financialCycleStartAndEndDatesArrayResult = $this->getCurrentAndActiveCaptainFinancialDueStartAndEndDatesByCaptainProfileId($captainId,
            $startAndEndDatesArrayResult[0], $startAndEndDatesArrayResult[1]);

        if ($financialCycleStartAndEndDatesArrayResult === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return $financialAccountDetails;
        }

        foreach ($financialSystemThreeDetails as $financialSystemThreePlan) {
            // Get the number of orders arranged according to the categories of the financial system
            $todayOrdersCount = $this->getDeliveredAndCancelledOrdersCountByCaptainProfileIdAndKilometerLimits($captainId,
                $fromDate, $toDate, $financialSystemThreePlan['countKilometersFrom'], $financialSystemThreePlan['countKilometersTo']);

            // Get the number of orders during the current and active financial cycle
            $financialCycleOrdersCount = $this->getDeliveredAndCancelledOrdersCountByCaptainProfileIdAndKilometerLimits($captainId,
                $financialCycleStartAndEndDatesArrayResult[0]->format('y-m-d 00:00:00'),
                $financialCycleStartAndEndDatesArrayResult[1]->format('y-m-d 23:59:59'), $financialSystemThreePlan['countKilometersFrom'],
                $financialSystemThreePlan['countKilometersTo']);

            // Calculate basic orders cost without bonus: total cost = order count * amount
            $financialAccountDetails['basicFinancialAmount'] += $todayOrdersCount * $financialSystemThreePlan['amount'];

            // Check if the captain achieve the required orders to gain the bonus
            if ($financialSystemThreePlan['bounceCountOrdersInMonth']) {
                //If the captain's achieve the order number of orders to get the bounce
                if ($financialCycleOrdersCount >= (float) $financialSystemThreePlan['bounceCountOrdersInMonth']) {
                    $financialAccountDetails['bounce'] += $financialSystemThreePlan['bounce'];

                } else {
                    $financialAccountDetails['bounce'] += 0;
                }

            } else {
                $financialAccountDetails['bounce'] += 0;
            }
        }

        return $financialAccountDetails;
    }
}
