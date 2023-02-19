<?php

namespace App\Constant\CaptainFinancialSystem\CaptainFinancialDaily;

final class CaptainFinancialDailyIsPaidConstant
{
    const CAPTAIN_FINANCIAL_DAILY_IS_NOT_PAID_CONST = 176;

    // The payment/s amount is equal to the financial daily amount
    const CAPTAIN_FINANCIAL_DAILY_IS_PAID_CONST = 177;

    // The payment/s amount is less than the financial daily amount
    const CAPTAIN_FINANCIAL_DAILY_IS_PAID_PARTIALLY_CONST = 179;

    // The payment/s amount is bigger than the financial daily amount
    const CAPTAIN_FINANCIAL_DAILY_IS_OVER_PAID_CONST = 182;
}
