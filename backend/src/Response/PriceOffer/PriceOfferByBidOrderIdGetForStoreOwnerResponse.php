<?php

namespace App\Response\PriceOffer;

use DateTime;

class PriceOfferByBidOrderIdGetForStoreOwnerResponse
{
    public int $id;

    public DateTime $createdAt;

    public DateTime $updatedAt;

    public float $priceOfferValue;

    public string $priceOfferStatus;

    public DateTime $offerDeadline;
}
