<?php

namespace App\Response\BidOrder;

use DateTime;
use OpenApi\Annotations as OA;

class BidOrderByIdForSupplierGetResponse
{
    public int $id;

    public string $title;

    public string $description;

    public DateTime $createdAt;

    public DateTime $updatedAt;

    /**
     * @OA\Property(type="array", property="images",
     *     @OA\Items(type="object"))
     */
    public $images;

    /**
     * @var bool|null
     */
    public $openToPriceOffer;

    /**
     * @OA\Property(type="array", property="priceOfferEntities",
     *     @OA\Items(type="object"))
     */
    public $priceOfferEntities;
}
