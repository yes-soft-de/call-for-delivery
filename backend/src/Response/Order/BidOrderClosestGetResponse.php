<?php

namespace App\Response\Order;

use DateTime;
use OpenApi\Annotations as OA;

class BidOrderClosestGetResponse
{
    public int $id;

    public int $bidDetailsId;

    public string $title;

    public string $state;

    public string $payment;

    public int $orderType;

    public string $note;

    public DateTime $deliveryDate;

    public DateTime $createdAt;

    /**
     * @OA\Property(type="array", property="sourceDestination",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $sourceDestination;

    /**
     * @OA\Property(type="array", property="location",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $location;

    public string $branchName;

    public string $storeOwnerName;
}
