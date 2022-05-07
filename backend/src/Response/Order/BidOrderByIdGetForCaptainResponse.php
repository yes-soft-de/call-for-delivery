<?php

namespace App\Response\Order;

use DateTime;
use OpenApi\Annotations as OA;

class BidOrderByIdGetForCaptainResponse
{
    public int $id;

    /**
     * @OA\Property(type="object", property="bidDetailsInfo")
     */
    public $bidDetailsInfo;

    public string $state;

    public string $payment;

    public int $orderType;

    /**
     * @var string|null
     */
    public $note;

    public DateTime $deliveryDate;

    public DateTime $createdAt;

    /**
     * @var string|null
     */
    public $detail;

    public string $storeOwnerName;

    /**
     * @var string|null
     */
    public $phone;

    /**
     * @var string|null
     */
    public $roomId;

    /**
     * @var float|null
     */
    public $rating;

    /**
     * @var string|null
     */
    public $ratingComment;

    /**
     * @OA\Property(type="array", property="orderLogs",
     *     @OA\Items(type="object"))
     */
    public $orderLogs;

    public int $storeId;

    /**
     * @var int|null
     */
    public $paidToProvider;
}
