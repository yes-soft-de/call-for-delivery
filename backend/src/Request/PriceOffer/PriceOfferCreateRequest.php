<?php

namespace App\Request\PriceOffer;

use App\Entity\BidDetailsEntity;
use App\Entity\SupplierProfileEntity;

class PriceOfferCreateRequest
{
    /**
     * @var int|BidDetailsEntity
     */
    private $bidDetails;

    /**
     * @var int|SupplierProfileEntity
     */
    private $supplierProfile;

    private float $priceOfferValue;

    /**
     * @var string|null
     */
    private $offerDeadline;

    public function getBidDetails(): BidDetailsEntity|int
    {
        return $this->bidDetails;
    }

    public function setBidDetails(BidDetailsEntity|int $bidDetails): void
    {
        $this->bidDetails = $bidDetails;
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
