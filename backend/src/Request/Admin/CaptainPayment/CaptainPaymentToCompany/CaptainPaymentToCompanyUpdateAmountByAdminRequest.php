<?php

namespace App\Request\Admin\CaptainPayment\CaptainPaymentToCompany;

class CaptainPaymentToCompanyUpdateAmountByAdminRequest
{
    private int $id;

    private float $amount;

    private int $operationType;

    public function getId(): int
    {
        return $this->id;
    }

    public function setId(int $id): void
    {
        $this->id = $id;
    }

    public function getAmount(): float
    {
        return $this->amount;
    }

    public function setAmount(float $amount): void
    {
        $this->amount = $amount;
    }

    public function getOperationType(): int
    {
        return $this->operationType;
    }

    public function setOperationType(int $operationType): void
    {
        $this->operationType = $operationType;
    }
}
