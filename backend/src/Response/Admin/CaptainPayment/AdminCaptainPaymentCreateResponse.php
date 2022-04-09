<?php

namespace App\Response\Admin\CaptainPayment;

class AdminCaptainPaymentCreateResponse
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
     * @var string|null
     */
    public $note;
}
