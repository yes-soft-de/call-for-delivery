<?php

namespace App\Response\PriceOffer;

use DateTime;

class PriceOfferDeleteResponse
{
    /**
     * @var int|null
     */
    public $id;

    public string $priceOfferStatus;

    public float $priceOfferValue;

    public DateTime $createdAt;

    public DateTime $updatedAt;
}
