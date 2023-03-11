<?php

namespace App\Response\Admin\CaptainPayment\PaymentToCaptain;

class CaptainPaymentFilterByAdminResponse
{
    public int $id;

    public float $amount;

    public \DateTime $createdAt;

    /**
     * @var string|null
     */
    public $note;
}
