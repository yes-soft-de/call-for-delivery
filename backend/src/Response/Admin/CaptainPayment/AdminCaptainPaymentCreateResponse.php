<?php

namespace App\Response\Admin\CaptainPayment;

use DateTime;

class AdminCaptainPaymentCreateResponse
{
    public int $id;

    public float $amount;

    public DateTime $createdAt;

    public ?string $note;
}
