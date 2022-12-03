<?php

namespace App\Request\Admin\Order;

class OrderUpdateIsCashPaymentConfirmedByStoreByAdminRequest
{   
    private int $id;

    private int $isCashPaymentConfirmedByStore;

    public function getId(): int
    {
        return $this->id;
    }

    public function getIsCashPaymentConfirmedByStore(): int
    {
        return $this->isCashPaymentConfirmedByStore;
    }
}
