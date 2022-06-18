<?php

namespace App\Request\Admin\Order;

class RePendingAcceptedOrderByAdminRequest
{
    private int $orderId;

    public function getOrderId(): int
    {
        return $this->orderId;
    }
}
