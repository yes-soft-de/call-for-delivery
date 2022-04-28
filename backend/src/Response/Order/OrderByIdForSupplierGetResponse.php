<?php

namespace App\Response\Order;

use DateTime;
use OpenApi\Annotations as OA;

class OrderByIdForSupplierGetResponse
{
    public int $id;

    public int $bidDetailsId;

    public string $state;

    public string $payment;

    /**
     * @var float|null
     */
    public $orderCost;

    public int $orderType;

    public string $note;

    /**
     * @var DateTime|null
     */
    public $deliveryDate;

    public string $title;

    public string $description;

    public DateTime $createdAt;

    /**
     * @var DateTime|null
     */
    public $updatedAt;

    /**
     * @OA\Property(type="array", property="bidDetailsImages",
     *     @OA\Items(type="object"))
     */
    public $bidDetailsImages;

    /**
     * @var bool|null
     */
    public $openToPriceOffer;

    /**
     * @OA\Property(type="array", property="pricesOffers",
     *     @OA\Items(type="object"))
     */
    public $pricesOffers;

    /**
     * @OA\Property(type="array", property="orderLogs",
     *     @OA\Items(type="object"))
     */
    public $orderLogs;
}
