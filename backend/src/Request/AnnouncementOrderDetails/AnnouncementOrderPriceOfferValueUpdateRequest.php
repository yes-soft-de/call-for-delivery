<?php

namespace App\Request\AnnouncementOrderDetails;

class AnnouncementOrderPriceOfferValueUpdateRequest
{
    private int $id;

    private float $priceOfferValue;

    private int $priceOfferStatus;

    public function getId(): int
    {
        return $this->id;
    }
}
