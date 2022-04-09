<?php

namespace App\Response\Admin\CaptainPayment;

class AdminCaptainPaymentResponse
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
     * @var int
     */
    public $captainId;

    /**
     * @var string
     */
    public $captainName;

    /**
     * @var null|string
     */
    public $note;
}
