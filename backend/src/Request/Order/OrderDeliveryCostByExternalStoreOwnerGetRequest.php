<?php

namespace App\Request\Order;

class OrderDeliveryCostByExternalStoreOwnerGetRequest
{
    private int $storeOwnerProfileId;

    private int $storeBranchId;

    private array $clientLocation;

    public function getStoreOwnerProfileId(): int
    {
        return $this->storeOwnerProfileId;
    }

    public function getStoreBranchId(): int
    {
        return $this->storeBranchId;
    }

    public function getClientLocation(): array
    {
        return $this->clientLocation;
    }
}
