<?php

namespace App\Response\CaptainFinancialSystem\CaptainFinancialDefaultSystem;

class CaptainFinancialDefaultSystemBalanceDetailsGetResponse
{
    // * today financial data
    public float $todayOrdersCount;

    public float $todayFinancialAmount;

    // * since last payment to captain data
    public float $sinceLastPaymentOrdersCount;

    public float $sinceLastPaymentFinancialAmount;

    public float $sinceLastPaymentCashOrderAmount;

    public float $sinceLastPaymentRemainFinancialAmount;

    // * captain financial default system info
    public int $captainFinancialSystemType;

    public float $openingOrderCost;

    public ?float $firstSliceLimit;

    public ?float $firstSliceCost;

    public ?float $secondSliceFromLimit;

    public ?float $secondSliceToLimit;

    public ?float $secondSliceOneKilometerCost;

    public ?float $thirdSliceFromLimit;

    public ?float $thirdSliceToLimit;

    public ?float $thirdSliceOneKilometerCost;
}
