<?php

namespace App\Response\StoreOwnerPayment;

class StoreOwnerPaymentResponse
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
    public $date;

    /**
     * @var null|string
     */
    public $note;
}
