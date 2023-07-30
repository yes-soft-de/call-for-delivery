<?php

namespace App\Response\Admin\CaptainFinancialSystem\CaptainFinancialDue;

use DateTime;

class CaptainFinancialDueUnpaidStatusGetForAdminResponse
{
    public int $id;

    public float $amount;

    public DateTime $startDate;

    public float $amountForStore;

    public float $finalAmount;

    //active = 1, inactive = 0
    public int $state;

    public ?int $lastPaymentId;

    public ?float $lastPaymentAmount;

    public ?DateTime $lastPaymentDate;
}
