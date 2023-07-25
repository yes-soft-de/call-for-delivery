<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDefaultSystem;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyResultConstant;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
use App\Constant\Order\OrderResultConstant;
use App\Constant\StoreOwnerDueFromCashOrder\StoreOwnerDueFromCashOrderStoreAmountConstant;
use App\Entity\CaptainFinancialDailyEntity;
use App\Entity\CaptainFinancialDuesEntity;
use App\Entity\OrderEntity;
use App\Entity\StoreOwnerDuesFromCashOrdersEntity;
use App\Response\CaptainFinancialSystem\CaptainFinancialDefaultSystem\CaptainFinancialDefaultSystemBalanceDetailsGetResponse;
use App\Service\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyGetService;
use App\Service\CaptainFinancialSystem\CaptainFinancialDue\CaptainFinancialDueGetService;
use App\Service\DateFactory\DateFactoryService;
use DateTime;

class CaptainFinancialDefaultSystemGetBalanceService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private CaptainFinancialDefaultSystemOrderGetService $captainFinancialDefaultSystemOrderGetService,
        private DateFactoryService $dateFactoryService,
        private CaptainFinancialDefaultSystemGetStoreAmountService $captainFinancialDefaultSystemGetStoreAmountService,
        private CaptainFinancialDailyGetService $captainFinancialDailyGetService,
        private CaptainFinancialDueGetService $captainFinancialDueGetService
    )
    {
    }

    public function getCurrentAndActiveCaptainFinancialDueByCaptainProfileId(int $captainProfileId): CaptainFinancialDuesEntity|int
    {
        return $this->captainFinancialDueGetService->getCurrentAndActiveCaptainFinancialDueByCaptainProfileId($captainProfileId);
    }

    public function getCaptainFinancialDailyByCaptainProfileIdAndSpecificDate(int $captainProfileId, DateTime $date, ?string $timeZone = null): CaptainFinancialDailyEntity|int
    {
        return $this->captainFinancialDailyGetService->getCaptainFinancialDailyByCaptainProfileIdAndSpecificDate($captainProfileId,
            $date, $timeZone);
    }

//    /**
//     * Get the dues of unpaid cash orders (for group of orders)
//     */
//    public function getUnPaidCashOrdersDueByCaptainProfileIdAndDuringSpecificTime(int $captainId, string $fromDate, string $toDate): string
//    {
//        return $this->captainFinancialDefaultSystemGetStoreAmountService->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainId,
//            $fromDate, $toDate);
//    }

    public function getUnPaidStoreOwnerDuesFromCashOrdersByOrderId(int $orderId): int|StoreOwnerDuesFromCashOrdersEntity
    {
        return $this->captainFinancialDefaultSystemGetStoreAmountService->getUnPaidStoreOwnerDuesFromCashOrdersByOrderId($orderId);
    }

//    public function getLastCaptainPaymentDateByCaptainProfileId(int $captainProfileId): \DateTimeInterface|int
//    {
//        return $this->captainPaymentGetService->getLastCaptainPaymentDateByCaptainProfileId($captainProfileId);
//    }

    public function getStartAndEndDateTimeOfToday(string $timeZone = null): array
    {
        return $this->dateFactoryService->getStartAndEndDateTimeOfToday($timeZone);
    }

    public function getDateTimeOfToday(string $timeZone = null): DateTime
    {
        return $this->dateFactoryService->getDateTimeOfToday($timeZone);
    }

    /**
     * Get delivered (or cancelled under specific circumstances) orders by specific captain and among specific date
     */
    public function getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialDefaultSystemOrderGetService->getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);
    }

    public function initializeCaptainBalanceResponse(array $financialSystemDetail): array
    {
        $response = [];

        // * today financial data
        $response['todayOrdersCount'] = 0.0;
        $response['todayFinancialAmount'] = 0.0;

        // * since last payment to captain data
        $response['sinceLastPaymentOrdersCount'] = 0.0;
        $response['sinceLastPaymentFinancialAmount'] = 0.0;
        $response['sinceLastPaymentCashOrderAmount'] = 0.0;
        // ** sinceLastPaymentRemainFinancialAmount = sinceLastPaymentFinancialAmount - sinceLastPaymentCashOrderAmount
        $response['sinceLastPaymentRemainFinancialAmount'] = 0.0;

        // * captain financial default system info
        $response['captainFinancialSystemType'] = $financialSystemDetail['captainFinancialSystemType'];

        $response['openingOrderCost'] = $financialSystemDetail['openingOrderCost'];
        $response['firstSliceLimit'] = $financialSystemDetail['firstSliceLimit'];
        $response['firstSliceCost'] = $financialSystemDetail['firstSliceCost'];
        $response['secondSliceFromLimit'] = $financialSystemDetail['secondSliceFromLimit'];
        $response['secondSliceToLimit'] = $financialSystemDetail['secondSliceToLimit'];
        $response['secondSliceOneKilometerCost'] = $financialSystemDetail['secondSliceOneKilometerCost'];
        $response['thirdSliceFromLimit'] = $financialSystemDetail['thirdSliceFromLimit'];
        $response['thirdSliceToLimit'] = $financialSystemDetail['thirdSliceToLimit'];
        $response['thirdSliceOneKilometerCost'] = $financialSystemDetail['thirdSliceOneKilometerCost'];

        return $response;
    }

//    /**
//     * For each order:
//     *      if order distance != null
//     *          if order distance <= 5 k
//     *              financial amount += (10 + 2.5)
//     *
//     *          else if order distance >= 6 AND order distance < 9
//     *              financial amount += (10 + (0.5 * order distance))
//     *
//     *          else if order distance >= 9
//     *              financial amount += (10 + (0.75 * order distance))
//     *
//     * final financial amount = financial amount - amount for store (which remains with the captain)
//     */
//    public function calculateCaptainFinancialAmountViaOrdersArray(array $orders, array $financialSystemDetail): float
//    {
//        $financialAmount = 0.0;
//
//        foreach ($orders as $order) {
//            $distance = $order['storeBranchToClientDistance'];
//
//            if ($distance) {
//                $financialAmount += $financialSystemDetail['openingOrderCost'];
//
//                if ($distance <= $financialSystemDetail['firstSliceLimit']) {
//                    $financialAmount += $financialSystemDetail['firstSliceCost'];
//
//                } elseif (($distance >= $financialSystemDetail['secondSliceFromLimit'])
//                    && ($distance < $financialSystemDetail['secondSliceToLimit'])) {
//                    $financialAmount += ($distance * $financialSystemDetail['secondSliceOneKilometerCost']);
//
//                } elseif ($distance >= $financialSystemDetail['thirdSliceFromLimit']) {
//                    $financialAmount += ($distance * $financialSystemDetail['thirdSliceOneKilometerCost']);
//                }
//            }
//        }
//
//        return $financialAmount;
//    }

    public function getCaptainBalanceDetails(int $captainProfileId, array $financialSystemDetail, ?string $timeZone = null): CaptainFinancialDefaultSystemBalanceDetailsGetResponse
    {
        $response = $this->initializeCaptainBalanceResponse($financialSystemDetail);

        // today financial data
        $todayDateWithoutTime = $this->getDateTimeOfToday($timeZone);
        $todayStartAndEndDates = $this->getStartAndEndDateTimeOfToday($timeZone);

        $orders = $this->getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates(
            $captainProfileId,
            ($todayStartAndEndDates[0])->format('Y-m-d H:i:s'),
            ($todayStartAndEndDates[1])->format('Y-m-d H:i:s')
        );

        $response['todayOrdersCount'] = count($orders);

        if ($response['todayOrdersCount'] > 0) {
            $captainFinancialDaily = $this->getCaptainFinancialDailyByCaptainProfileIdAndSpecificDate($captainProfileId,
                $todayDateWithoutTime, $timeZone);

            if ($captainFinancialDaily !== CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST) {
                $response['todayFinancialAmount'] = $captainFinancialDaily->getAmount();
            }
        }

        // since last payment financial data
        $captainFinancialDue = $this->getCurrentAndActiveCaptainFinancialDueByCaptainProfileId($captainProfileId);

        if ($captainFinancialDue !== CaptainFinancialDues::FINANCIAL_NOT_FOUND) {
            $fromDate = $captainFinancialDue->getStartDate();

            $sinceLastPaymentOrders = $this->getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
                $fromDate->format('Y-m-d H:i:s'), (new \DateTime('now'))->format('Y-m-d H:i:s'));

            $sinceLastPaymentOrdersCount = count($sinceLastPaymentOrders);

            $response['sinceLastPaymentOrdersCount'] = $sinceLastPaymentOrdersCount;

            $response['sinceLastPaymentCashOrderAmount'] = $captainFinancialDue->getAmountForStore();

            $response['sinceLastPaymentFinancialAmount'] = $captainFinancialDue->getAmount();

            // ** sinceLastPaymentRemainFinancialAmount = sinceLastPaymentFinancialAmount - sinceLastPaymentCashOrderAmount
            $response['sinceLastPaymentRemainFinancialAmount'] = $response['sinceLastPaymentFinancialAmount'] - $response['sinceLastPaymentCashOrderAmount'];

        }

        return $this->autoMapping->map('array', CaptainFinancialDefaultSystemBalanceDetailsGetResponse::class,
            $response);
    }

    /**
     *      if order distance != null
     *          if order distance <= 5 k
     *              financial amount += (10 + 2.5)
     *
     *          else if order distance >= 6 AND order distance < 9
     *              financial amount += (10 + (0.5 * order distance))
     *
     *          else if order distance >= 9
     *              financial amount += (10 + (0.75 * order distance))
     *
     */
    public function calculateCaptainFinancialAmountForSingleOrder(OrderEntity $order, array $financialSystemDetail): float
    {
        $financialAmount = 0.0;

        $distance = $order->getStoreBranchToClientDistance();

        if ($distance !== null) {
            $financialAmount += $financialSystemDetail['openingOrderCost'];

            if ($distance <= $financialSystemDetail['firstSliceLimit']) {
                $financialAmount += $financialSystemDetail['firstSliceCost'];

            } elseif (($distance >= $financialSystemDetail['secondSliceFromLimit'])
                && ($distance < $financialSystemDetail['secondSliceToLimit'])) {
                $financialAmount += ($distance * $financialSystemDetail['secondSliceOneKilometerCost']);

            } elseif ($distance >= $financialSystemDetail['thirdSliceFromLimit']) {
                $financialAmount += ($distance * $financialSystemDetail['thirdSliceOneKilometerCost']);
            }
        }

        return $financialAmount;
    }

    /**
     * This function retrieve and initialize necessary fields for captain financial dues calculation
     */
    public function initializeNecessaryFieldsForDuesCalculation(array $financialSystemDetail): array
    {
        $response = [];

        $response['captainFinancialSystemType'] = $financialSystemDetail['captainFinancialSystemType'];
        $response['financialDues'] = 0.0;

        // cash orders sum (which will be forwarded from captain to administration
        $response['amountForStore'] = 0.0;

        return $response;
    }

    public function getOrderEntityById(int $orderId): OrderEntity|string
    {
        return $this->captainFinancialDefaultSystemOrderGetService->getOrderEntityById($orderId);
    }

    /**
     *  To prepare the financial details for the captain
     */
    public function calculateCaptainDues(array $financialSystemDetail, int $orderId): array
    {
        $response = $this->initializeNecessaryFieldsForDuesCalculation($financialSystemDetail);

        $orders = $this->getOrderEntityById($orderId);

        if ($orders !== OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            $response['financialDues'] = $this->calculateCaptainFinancialAmountForSingleOrder($orders, $financialSystemDetail);
        }

        // Get the amount of the due of unpaid cash order that the captain delivered
        $storeDueFromCashOrder = $this->getUnPaidStoreOwnerDuesFromCashOrdersByOrderId($orderId);

        if ($storeDueFromCashOrder !== StoreOwnerDueFromCashOrderStoreAmountConstant::STORE_DUE_FROM_CASH_ORDER_NOT_EXIST_CONST) {
            $response['amountForStore'] = $storeDueFromCashOrder->getAmount();
        }

        return $response;
    }
}
