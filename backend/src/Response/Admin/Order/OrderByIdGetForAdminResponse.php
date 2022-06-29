<?php

namespace App\Response\Admin\Order;

use DateTime;
use OpenApi\Annotations as OA;

class OrderByIdGetForAdminResponse
{
    public int $id;

    public string $state;

    public string $payment;

    /**
     * @var float|null
     */
    public $orderCost;

    public int $orderType;

    /**
     * @OA\Property(type="array", property="orderLogs",
     *     @OA\Items(type="object"))
     */
    public $orderLogs;

    /**
     * @var string|null $note
     */
    public $note;

    public DateTime $deliveryDate;

    public DateTime $createdAt;

    /**
     * @var DateTime|null $note
     */
    public $updatedAt;

    /**
     * @var float|null $kilometer
     */
    public $kilometer;

    /**
     * @var int|null $storeOrderDetailsId
     */
    public $storeOrderDetailsId;

    /**
     * @OA\Property(type="object", property="destination")
     */
    public $destination;

    /**
     * @var string|null $recipientName
     */
    public $recipientName;

    /**
     * @var string|null $recipientPhone
     */
    public $recipientPhone;

    /**
     * @var string|null $detail
     */
    public $detail;

    public int $storeOwnerBranchId;

    /**
     * @OA\Property(type="object", property="location")
     */
    public $location;

    public string $branchName;

    /**
     * @OA\Property(type="array", property="orderImage",
     *     @OA\Items(type="object"))
     */
    public $orderImage;

    /**
     * @var int|null $captainUserId
     */
    public $captainUserId;

    /**
     * @var string|null $captainName
     */
    public $captainName;

    /**
     * @var string|null $phone
     */
    public $phone;

    public int|null $paidToProvider;

    public int $storeOwnerId;

    public string|null $storeOwnerName;

    public float|null $captainOrderCost;

    public string|null $noteCaptainOrderCost;
}
