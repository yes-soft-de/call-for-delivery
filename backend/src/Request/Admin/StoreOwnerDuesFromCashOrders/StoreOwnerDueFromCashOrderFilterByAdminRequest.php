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

    /**
     * @var string|null
     */
    private $year;

    public function getStoreOwnerProfileId(): ?int
    {
        return $this->storeOwnerProfileId;
    }

    /**
     * @param string|null $fromDate
     */
    public function setFromDate(?string $fromDate): void
    {
        $this->fromDate = $fromDate;
    }

    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    /**
     * @param string|null $toDate
     */
    public function setToDate(?string $toDate): void
    {
        $this->toDate = $toDate;
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

    public function getYear(): ?string
    {
        return $this->year;
    }
}
