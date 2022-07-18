<?php

namespace App\Response\Admin\Order;

use DateTime;
use OpenApi\Annotations as OA;

class OrderGetForAdminResponse
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
     * @var string|null
     */
    public $note;

    /**
     * @var DateTime|null
     */
    public $deliveryDate;

    /**
     * @var DateTime|null
     */
    public $createdAt;

    /**
     * @var DateTime|null
     */
    public $updatedAt;

    /**
     * @var float|null
     */
    public $kilometer;

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
     * @OA\Property(type="array", property="location",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $location;

    /**
     * @var string|null
     */
    public $branchName;

    /**
     * @var int|null
     */
    public $imageId;

    /**
     * @OA\Property(type="array", property="images",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $images;
    
    /**
     * @var int
     */
    public $countOrders;
}
