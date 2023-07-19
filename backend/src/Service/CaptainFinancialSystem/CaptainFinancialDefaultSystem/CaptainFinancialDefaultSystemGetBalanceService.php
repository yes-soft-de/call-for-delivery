<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDefaultSystem;

use App\AutoMapping;
use App\Constant\CaptainPayment\PaymentToCaptain\CaptainPaymentResultConstant;
use App\Response\CaptainFinancialSystem\CaptainFinancialDefaultSystem\CaptainFinancialDefaultSystemBalanceDetailsGetResponse;
use App\Service\CaptainPayment\CaptainPaymentGetService;
use App\Service\DateFactory\DateFactoryService;

class CaptainFinancialDefaultSystemGetBalanceService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private CaptainFinancialDefaultSystemOrderGetService $captainFinancialDefaultSystemOrderGetService,
        private DateFactoryService $dateFactoryService,
        private CaptainPaymentGetService $captainPaymentGetService,
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

    public function getLastCaptainPaymentDateByCaptainProfileId(int $captainProfileId): \DateTimeInterface|int
    {
        return $this->captainPaymentGetService->getLastCaptainPaymentDateByCaptainProfileId($captainProfileId);
    }

    public function getStartAndEndDateTimeOfToday(string $timeZone = null): array
    {
        return $this->dateFactoryService->getStartAndEndDateTimeOfToday($timeZone);
    }

    /**
     * Get delivered (or cancelled under specific circumstances) orders by specific captain and among specific date
     */
    public function getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialDefaultSystemOrderGetService->getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId, $fromDate, $toDate);
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

    /**
     * For each order:
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
     * final financial amount = financial amount - amount for store (which remains with the captain)
     */
    public function calculateCaptainFinancialAmountViaOrdersArray(array $orders, array $financialSystemDetail): float
    {
        $financialAmount = 0.0;

        foreach ($orders as $order) {
            $distance = $order['storeBranchToClientDistance'];

            if ($distance) {
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
        }

        return $financialAmount;
    }

    public function getCaptainBalanceDetails(int $captainProfileId, array $financialSystemDetail): CaptainFinancialDefaultSystemBalanceDetailsGetResponse
    {
        $response = $this->initializeCaptainBalanceResponse($financialSystemDetail);

        // today financial data
        $todayStartAndEndDates = $this->getStartAndEndDateTimeOfToday();

        $orders = $this->getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates(
            $captainProfileId,
            ($todayStartAndEndDates[0])->format('Y-m-d h:m:s'),
            ($todayStartAndEndDates[1])->format('Y-m-d h:m:s')
        );

        $response['todayOrdersCount'] = count($orders);

        if ($response['todayOrdersCount'] > 0) {
            $response['todayFinancialAmount'] = $this->calculateCaptainFinancialAmountViaOrdersArray($orders,
                $financialSystemDetail);
        }

        // since last payment financial data
        $captainPaymentCreationDate = $this->getLastCaptainPaymentDateByCaptainProfileId($captainProfileId);

        if ($captainPaymentCreationDate === CaptainPaymentResultConstant::CAPTAIN_PAYMENT_NOT_EXIST) {
            // no payment exist, so get the orders since 2023-07-18 until now
            $fromDate = (new \DateTime('2023-07-18 00:00:00'))->format('Y-m-d h:m:s');

        } else {
            // get the orders since last payment date until now
            $fromDate = ($captainPaymentCreationDate)->format('Y-m-d h:m:s');
        }

        $sinceLastPaymentOrders = $this->getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId, $fromDate,
            (new \DateTime('now'))->format('Y-m-d h:m:s'));

        $sinceLastPaymentOrdersCount = count($sinceLastPaymentOrders);

        $response['sinceLastPaymentOrdersCount'] = $sinceLastPaymentOrdersCount;

        $response['sinceLastPaymentCashOrderAmount'] = $this->getUnPaidCashOrdersDueByCaptainProfileIdAndDuringSpecificTime($captainProfileId,
            $fromDate, (new \DateTime('now'))->format('Y-m-d h:m:s'));

        if ($sinceLastPaymentOrdersCount > 0) {
            $response['sinceLastPaymentFinancialAmount'] = $this->calculateCaptainFinancialAmountViaOrdersArray($sinceLastPaymentOrders,
                $financialSystemDetail);
        }

        // ** sinceLastPaymentRemainFinancialAmount = sinceLastPaymentFinancialAmount - sinceLastPaymentCashOrderAmount
        $response['sinceLastPaymentRemainFinancialAmount'] = $response['sinceLastPaymentFinancialAmount'] - $response['sinceLastPaymentCashOrderAmount'];

        return $this->autoMapping->map('array', CaptainFinancialDefaultSystemBalanceDetailsGetResponse::class,
            $response);
    }
}
