<?php

namespace App\Response\PriceOffer;

use DateTime;
use OpenApi\Annotations as OA;

class PriceOfferByBidOrderIdGetForStoreOwnerResponse
{
    public int $id;

    public DateTime $createdAt;

    public DateTime $updatedAt;

    public float $priceOfferValue;

    public string $priceOfferStatus;

    public DateTime $offerDeadline;

    public int $deliveryCarId;

    public string $carModel;

    public float $deliveryCost;

    /**
     * @var string|null
     */
    public $details;
}
