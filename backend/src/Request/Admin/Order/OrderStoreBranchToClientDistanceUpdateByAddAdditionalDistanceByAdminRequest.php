<?php

namespace App\Request\Admin\Order;

class OrderStoreBranchToClientDistanceUpdateByAddAdditionalDistanceByAdminRequest
{
    private int $orderId;

    private float $additionalDistance;

    public function getOrderId(): int
    {
        return $this->orderId;
    }

    public function getAdditionalDistance(): float
    {
        return $this->additionalDistance;
    }
}
