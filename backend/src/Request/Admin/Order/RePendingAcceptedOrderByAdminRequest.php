<?php

namespace App\Request\Admin\Order;

// holds the id of the order which is being returned to a pending one
class RePendingAcceptedOrderByAdminRequest
{
    private int $orderId;

    public function getOrderId(): int
    {
        return $this->orderId;
    }
}
