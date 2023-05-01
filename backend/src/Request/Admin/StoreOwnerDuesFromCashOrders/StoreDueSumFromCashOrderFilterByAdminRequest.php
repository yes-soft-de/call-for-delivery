<?php

namespace App\Request\Admin\StoreOwnerDuesFromCashOrders;

class StoreDueSumFromCashOrderFilterByAdminRequest
{
    /**
     * @var int|null
     */
    private $isPaid;

    public function getIsPaid(): ?int
    {
        return $this->isPaid;
    }
}
