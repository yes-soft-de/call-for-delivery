<?php

namespace App\Response\Admin\CaptainPayment\PaymentToCaptain;

use DateTime;

class CaptainPaymentFilterByAdminV2Response
{
    public int $id;

    public float $amount;

    public DateTime $createdAt;

    public int $paymentGetaway;
}
