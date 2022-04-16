<?php

namespace App\Request\Order;

class AnnouncementOrderFilterBySupplierRequest
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
     * @var int|null
     */
    private $priceOfferStatus;

    private int $supplierId;

    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    public function getToDate(): ?string
    {
        return $this->toDate;
    }

    public function getPriceOfferStatus(): ?int
    {
        return $this->priceOfferStatus;
    }

    public function setSupplierId(int $supplierId): void
    {
        $this->supplierId = $supplierId;
    }

    public function getSupplierId(): int
    {
        return $this->supplierId;
    }
}
