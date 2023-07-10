<?php

namespace App\Response\Admin\EPaymentFromStore;

use DateTime;

class EPaymentFromStoreGetForAdminResponse
{
    public int $id;

    public int $paymentGetaway;

    public float $amount;

    public int $paymentFor;

    public ?string $details;

    public DateTime $createdAt;

    public DateTime $updatedAt;

    // indicates who did the payment, and it is real or mock payment
    public ?int $paymentType;

    public int $createdBy;
}
