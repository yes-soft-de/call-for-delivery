<?php

namespace App\Request\Admin\CaptainAmountFromOrderCash;

class CaptainAmountFromOrderCashDeleteByAdminRequest
{
    private int $captainProfileId;

    private int $orderId;

    public function getCaptainProfileId(): int
    {
        return $this->captainProfileId;
    }

    public function setCaptainProfileId(int $captainProfileId): void
    {
        $this->captainProfileId = $captainProfileId;
    }

    public function getOrderId(): int
    {
        return $this->orderId;
    }

    public function setOrderId(int $orderId): void
    {
        $this->orderId = $orderId;
    }
}
