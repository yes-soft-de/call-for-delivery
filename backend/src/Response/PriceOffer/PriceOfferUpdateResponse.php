<?php

namespace App\Response\PriceOffer;

use DateTime;

class PriceOfferUpdateResponse
{
    public int $id;

    public string $priceOfferStatus;

    public float $priceOfferValue;

    public DateTime $createdAt;

    public DateTime $updatedAt;
}
