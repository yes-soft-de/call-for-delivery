<?php

namespace App\Request\Admin\CaptainPayment\PaymentToCaptain;

class CaptainPaymentAmountAndNoteUpdateByAdminRequest
{
    private int $id;

    private float $amount;

    private string $note;

    public function getId(): int
    {
        return $this->id;
    }
}
