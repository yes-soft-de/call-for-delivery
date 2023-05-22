<?php

namespace App\Request\Admin\OrderDistanceConflict;

class OrderDistanceConflictFilterByAdminRequest
{
    /**
     * @var bool|null
     */
    private $isResolved;

    /**
     * @var string|null
     */
    private $fromDate;

    /**
     * @var string|null
     */
    private $toDate;

    /**
     * @var null|string
     */
    private $customizedTimezone;

    /**
     * @var int|null
     */
    private $storeOwnerProfileId;

    /**
     * @var int|null
     */
    private $storeBranchId;

    public function getIsResolved(): ?bool
    {
        return $this->isResolved;
    }

    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    public function getToDate(): ?string
    {
        return $this->toDate;
    }

    public function getCustomizedTimezone(): ?string
    {
        return $this->customizedTimezone;
    }

    public function getStoreOwnerProfileId(): ?int
    {
        return $this->storeOwnerProfileId;
    }

    public function getStoreBranchId(): ?int
    {
        return $this->storeBranchId;
    }
}
