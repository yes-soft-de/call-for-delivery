<?php

namespace App\Request\StreetLine;

class StreetLineOrderStatusUpdateRequest
{
    private int $order_id;

    private string $status;

    public function getOrderId(): int
    {
        return $this->order_id;
    }

    public function setOrderId(int $order_id): void
    {
        $this->order_id = $order_id;
    }

    public function getStatus(): string
    {
        return $this->status;
    }
}
