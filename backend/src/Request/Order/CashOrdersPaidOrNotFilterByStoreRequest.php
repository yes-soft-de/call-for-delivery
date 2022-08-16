<?php

namespace App\Request\Order;

class CashOrdersPaidOrNotFilterByStoreRequest
{
    /**
     * @var string|null
     */
    private $fromDate;

    /**
     * @var string|null
     */
    private $toDate;

    // user id of the store owner
    private int $storeOwnerUserId;

    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    public function getToDate(): ?string
    {
        return $this->toDate;
    }

    public function getStoreOwnerUserId(): int
    {
        return $this->storeOwnerUserId;
    }

    public function setStoreOwnerUserId(int $storeOwnerUserId): void
    {
        $this->storeOwnerUserId = $storeOwnerUserId;
    }
}
