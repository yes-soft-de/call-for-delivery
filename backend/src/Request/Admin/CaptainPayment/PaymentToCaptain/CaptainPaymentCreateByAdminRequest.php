<?php

namespace App\Request\Admin\CaptainPayment\PaymentToCaptain;

use App\Entity\CaptainEntity;

/**
 * This for creating payment to captain by admin (new API)
 */
class CaptainPaymentCreateByAdminRequest
{
    private float $amount;

    private string $note;

    private int|CaptainEntity $captain;

    private string $paymentId;

    private int $paymentGetaway;

    private int $paymentFor;

    private int $paymentType;

    private int $createdBy;
}
