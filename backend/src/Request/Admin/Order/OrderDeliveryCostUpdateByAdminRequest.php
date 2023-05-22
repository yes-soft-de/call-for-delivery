<?php

namespace App\Request\Admin\Order;

class OrderDeliveryCostUpdateByAdminRequest
{
    /**
     * order id
     */
    private int $id;

    private float $deliveryCost;

    public function getId(): int
    {
        return $this->id;
    }

    public function setId(int $id): void
    {
        $this->id = $id;
    }

    public function setDeliveryCost(float $deliveryCost): void
    {
        $this->deliveryCost = $deliveryCost;
    }
}
