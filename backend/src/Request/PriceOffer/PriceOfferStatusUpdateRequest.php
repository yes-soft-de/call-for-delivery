<?php

namespace App\Request\PriceOffer;

class PriceOfferStatusUpdateRequest
{
    private int $id;

    private string $priceOfferStatus;

    public function getId(): int
    {
        return $this->id;
    }

    public function getPriceOfferStatus(): string
    {
        return $this->priceOfferStatus;
    }
}
