<?php

namespace App\Request\Admin\Order;

class FilterDifferentlyAnsweredCashOrdersByAdminRequest
{
    /**
     * @var string|null
     */
    private $fromDate;

    /**
     * @var string|null
     */
    private $toDate;

    /**
     * @var int|null|string
     */
    private $storeProfileId;

    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    public function getToDate(): ?string
    {
        return $this->toDate;
    }

    public function getStoreProfileId(): int|string|null
    {
        return $this->storeProfileId;
    }
}
