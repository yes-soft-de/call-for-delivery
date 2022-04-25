<?php

namespace App\Response\Order;

use DateTime;
use OpenApi\Annotations as OA;

class BidOrderForStoreOwnerGetResponse
{
    public int $id;

    public int $bidOrderId;

    /**
     * @var string|null
     */
    public $title;

    /**
     * @var string|null
     */
    public $description;

    public int $supplierCategoryId;

    public string $supplierCategoryName;

    public bool $openToPriceOffer;

    public string $state;

    public string $payment;

    /**
     * @var float|null
     */
    public $orderCost;

    public int $orderType;

    /**
     * @var string|null
     */
    public $note;

    /**
     * @var DateTime|null
     */
    public $deliveryDate;

    public DateTime $createdAt;

    /**
     * @var int|null
     */
    public $storeOrderDetailsId;

    /**
     * @OA\Property(type="array", property="destination",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $destination;

    /**
     * @var string|null
     */
    public $recipientName;

    /**
     * @var string|null
     */
    public $recipientPhone;

    /**
     * @var string|null
     */
    public $detail;

    /**
     * @var int|null
     */
    public $storeOwnerBranchId;

    /**
     * @var string|null
     */
    public $branchName;

    /**
     * @OA\Property(type="array", property="bidOrderImages",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $bidOrderImages;

    /**
     * @var int|null
     */
    public $captainUserId;

    /**
     * @var string|null
     */
    public $roomId;

    /**
     * @var string|null
     */
    public $captainName;

    /**
     * @var bool|null
     */
    public $isCaptainArrived;

    /**
     * @var DateTime|null
     */
    public $dateCaptainArrived;

    /**
     * @var string|null
     */
    public $branchPhone;

    /**
     * @var string|null
     */
    public $attention;

    /**
     * @var float|null
     */
    public $captainOrderCost;

    /**
     * @OA\Property(type="array", property="orderLogs",
     *     @OA\Items(type="object"))
     */
    public $orderLogs;
}
