<?php

namespace App\Request\Admin\StoreOwnerDuesFromCashOrders;

class StoreOwnerDueFromCashOrderFilterByAdminRequest
{
    /**
     * @var int|null
     */
    private $storeOwnerProfileId;

    /**
     * @var string|null
     */
    private $fromDate;

    /**
     * @var string|null
     */
    private $toDate;

    /**
     * 1: paid. 2: not paid
     *
     * @var int|null
     */
    private $isPaid;

    /**
     * @var string|null
     */
    private $customizedTimezone;

    public function getStoreOwnerProfileId(): ?int
    {
        return $this->storeOwnerProfileId;
    }

    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    public function getToDate(): ?string
    {
        return $this->toDate;
    }

    public function getIsPaid(): ?int
    {
        return $this->isPaid;
    }

    public function getCustomizedTimezone(): ?string
    {
        return $this->customizedTimezone;
    }
}
