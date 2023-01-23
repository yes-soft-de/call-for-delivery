<?php

namespace App\Request\Order;

class OrderDeliveryCostUpdateRequest
{
    private int $id;

    private float $deliveryCost;

    public function setId(int $id): void
    {
        $this->id = $id;
    }

    public function getId(): int
    {
        return $this->id;
    }

    public function setDeliveryCost(float $deliveryCost): void
    {
        $this->deliveryCost = $deliveryCost;
    }
}
