<?php

namespace App\Response\Admin\CaptainPayment\PaymentToCaptain;

use DateTime;

class CaptainPaymentAmountAndNoteUpdateByAdminResponse
{
    public int $id;

    public float $amount;

    public DateTime $createdAt;

    /**
     * @var string|null
     */
    public $note;

    public DateTime $updatedAt;
}
