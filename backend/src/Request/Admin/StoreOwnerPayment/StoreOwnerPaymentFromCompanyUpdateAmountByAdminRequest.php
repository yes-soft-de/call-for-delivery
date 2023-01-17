<?php

namespace App\Request\Admin\StoreOwnerPayment;

class StoreOwnerPaymentFromCompanyUpdateAmountByAdminRequest
{
    private int $id;

    private float $cashAmount;

    private int $operationType;

    public function getId(): int
    {
        return $this->id;
    }

    public function setId(int $id): void
    {
        $this->id = $id;
    }

    public function getCashAmount(): float
    {
        return $this->cashAmount;
    }

    public function setCashAmount(float $cashAmount): void
    {
        $this->cashAmount = $cashAmount;
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
