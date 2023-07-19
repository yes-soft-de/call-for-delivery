<?php

namespace App\Response\CaptainPayment;

use DateTime;

class CaptainPaymentFilterResponse
{
    public int $id;

    public float $amount;

    public DateTime $createdAt;

    public int $paymentGetaway;
}
