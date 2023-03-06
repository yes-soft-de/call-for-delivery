<?php

namespace App\Response\Admin\CaptainPayment\PaymentToCaptain;

use DateTime;

class CaptainPaymentForCaptainFinancialDailyCreateByAdminResponse
{
    public int $id;

    public float $amount;

    public DateTime $createdAt;

    /**
     * @var string|null
     */
    public $note;
}
