<?php

namespace App\Request\Admin\StreetLine;

class OrderInStreetLineCancelByAdminRequest
{
    private int $orderId;

    public function getOrderId(): int
    {
        return $this->orderId;
    }
}
