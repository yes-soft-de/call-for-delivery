<?php

namespace App\Request\Admin\Order;

class OrderFilterByAdminRequest
{
    /**
     * @var string|null
     */
    private $state;

    /**
     * @var string|null
     */
    private $fromDate;

    /**
     * @var string|null
     */
    private $toDate;

    /**
     * @var int|null
     */
    private $storeOwnerProfileId;

    /**
     * @var bool|null
     */
    private $openToPriceOffer;

    /**
     * @var float|null|string
     */
    private $kilometer;

    /**
     * @var float|null|string
     */
    private $storeBranchToClientDistance;

    /**
     * @return string|null
     */
    public function getState(): ?string
    {
        return $this->state;
    }

    /**
     * @return string|null
     */
    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    /**
     * @return string|null
     */
    public function getToDate(): ?string
    {
        return $this->toDate;
    }

    /**
     * @return int|null
     */
    public function getStoreOwnerProfileId(): ?int
    {
        return $this->storeOwnerProfileId;
    }

    /**
     * @return bool|null
     */
    public function getOpenToPriceOffer(): ?bool
    {
        return $this->openToPriceOffer;
    }

    public function getKilometer(): float|null|string
    {
        return $this->kilometer;
    }

    public function getStoreBranchToClientDistance(): float|null|string
    {
        return $this->storeBranchToClientDistance;
    }
}
