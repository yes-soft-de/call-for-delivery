<?php

namespace App\Response\CaptainFinancialSystem\CaptainFinancialDefaultSystem;

class CaptainFinancialDefaultSystemBalanceDetailsGetResponse
{
    public float $todayOrdersCount;

    public float $todayFinancialAmount;

    public float $sinceLastPaymentOrdersCount;

    public float $sinceLastPaymentFinancialAmount;

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
