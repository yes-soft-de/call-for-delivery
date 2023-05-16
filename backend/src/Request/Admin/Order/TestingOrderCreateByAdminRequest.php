<?php

namespace App\Request\Admin\Order;

use App\Entity\StoreOwnerBranchEntity;
use App\Entity\StoreOwnerProfileEntity;

/**
 * Request object for creating order/s by admin for testing purposes
 */
class TestingOrderCreateByAdminRequest
{
    /**
     * The id of the store owner profile
     *
     * @var int|StoreOwnerProfileEntity
     */
    private $storeOwner;

    /**
     * The id of the store's branch
     *
     * @var int|StoreOwnerBranchEntity
     */
    private $branch;

    private bool $orderIsMain = false;

    /**
     * how many order we need to create
     *
     * @var int|null
     */
    private $ordersCount;

    public function setStoreOwner(int|StoreOwnerProfileEntity $storeOwner): void
    {
        $this->storeOwner = $storeOwner;
    }

    public function getStoreOwner(): int|StoreOwnerProfileEntity
    {
        return $this->storeOwner;
    }

    public function setBranch(StoreOwnerBranchEntity|int $branch): void
    {
        $this->branch = $branch;
    }

    public function getBranch(): int|StoreOwnerBranchEntity
    {
        return $this->branch;
    }

    public function isOrderIsMain(): bool
    {
        return $this->orderIsMain;
    }

    public function setOrdersCount(int $ordersCount): void
    {
        $this->ordersCount = $ordersCount;
    }

    public function getOrdersCount(): ?int
    {
        return $this->ordersCount;
    }
}
