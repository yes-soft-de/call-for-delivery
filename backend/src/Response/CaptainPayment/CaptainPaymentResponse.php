<?php

namespace App\Response\CaptainPayment;

class CaptainPaymentResponse
{
    /**
     * @var int
     */
    public $id;

    /**
     * @var float
     */
    public $amount;

    /**
     * @var array
     */
    public $createdAt;

    /**
     * @var null|string
     */
    public $note;
}
