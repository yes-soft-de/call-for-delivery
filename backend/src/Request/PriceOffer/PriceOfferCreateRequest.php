<?php

namespace App\Request\PriceOffer;

use App\Entity\BidOrderEntity;
use App\Entity\SupplierProfileEntity;

class PriceOfferCreateRequest
{
    /**
     * @var int|BidOrderEntity
     */
    private $bidOrder;

    /**
     * @var int|SupplierProfileEntity
     */
    private $supplierProfile;

    private float $priceOfferValue;

    /**
     * @var string|null
     */
    private $offerDeadline;

    public function getBidOrder(): BidOrderEntity|int
    {
        return $this->bidOrder;
    }

    public function setBidOrder(BidOrderEntity|int $bidOrder): void
    {
        $this->bidOrder = $bidOrder;
    }

    public function getSupplierProfile(): SupplierProfileEntity|int
    {
        return $this->supplierProfile;
    }

    public function setSupplierProfile(SupplierProfileEntity|int $supplierProfile): void
    {
        $this->supplierProfile = $supplierProfile;
    }

    public function getOfferDeadline(): ?string
    {
        return $this->offerDeadline;
    }
}
