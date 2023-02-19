<?php

namespace App\Request\Admin\CaptainPayment\PaymentToCaptain;

class CaptainPaymentDeleteByAdminRequest
{
    private int $id;

    public function getId(): int
    {
        return $this->id;
    }
}
