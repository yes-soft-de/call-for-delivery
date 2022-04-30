<?php

namespace App\Response\Order;

use DateTime;
use OpenApi\Annotations as OA;

class BidOrderByIdGetForAdminResponse
{
    public int $id;

    public string $state;

    public string $payment;

    public float $orderCost;

    public int $orderType;

    /**
     * @OA\Property(type="array", property="orderLogs",
     *     @OA\Items(type="object"))
     */
    public $orderLogs;

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
     * @var DateTime|null
     */
    public $updatedAt;

    /**
     * @var int|null
     */
    public $kilometer;

    /**
     * @var int|null
     */
    public $storeOwnerProfileId;

    /**
     * @var int|null
     */
    public $storeOwnerId;

    /**
     * @var string|null
     */
    public $storeOwnerName;

    /**
     * @var string|null
     */
    public $storeOwnerPhone;

    /**
     * @var int|null
     */
    public $storeOwnerBranchId;

    /**
     * @var string|null
     */
    public $storeOwnerBranchPhone;

    /**
     * @OA\Property(type="object", property="storeOwnerBranchLocation")
     */
    public $storeOwnerBranchLocation;

    /**
     * @var int|null
     */
    public $captainUserId;

    /**
     * @var string|null
     */
    public $captainName;

    /**
     * @var string|null
     */
    public $phone;

    /**
     * @var float|null
     */
    public $captainOrderCost;

    /**
     * @var DateTime|null
     */
    public $dateCaptainArrived;

    /**
     * @var bool|null
     */
    public $isCaptainArrived;

    /**
     * @OA\Property(type="object", property="orderLogs")
     */
    public $bidDetails;
}
