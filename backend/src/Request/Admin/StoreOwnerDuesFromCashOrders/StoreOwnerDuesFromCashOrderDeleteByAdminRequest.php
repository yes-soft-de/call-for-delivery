<?php

namespace App\Request\Admin\StoreOwnerDuesFromCashOrders;

class StoreOwnerDuesFromCashOrderDeleteByAdminRequest
{
    private int $storeOwnerProfileId;

    private int $orderId;

    public function getStoreOwnerProfileId(): int
    {
        return $this->storeOwnerProfileId;
    }

    public function setStoreOwnerProfileId(int $storeOwnerProfileId): void
    {
        $this->storeOwnerProfileId = $storeOwnerProfileId;
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
