<?php

namespace App\Response\Admin\Order;

use OpenApi\Annotations as OA;
use DateTime;

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
     * @OA\Property(type="object", property="deliveryDate")
     */
    public DateTime $deliveryDate;

     /**
     * @OA\Property(type="object", property="createdAt")
     */
    public DateTime $createdAt;

    /**
     * @OA\Property(type="object", property="updatedAt")
     */
    public DateTime|null $updatedAt;

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
     *     @OA\Items(type="object"))
     */
    public array|null $destination;

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
     * @OA\Property(type="object", property="location")
     */
    public array|null $location;

    /**
     * @var string|null
     */
    public $branchName;

    /**
     * @var int|null
     */
    public $imageId;

    /**
     * @OA\Property(type="object", property="images")
     */
    public array|null $images;

    /**
     * @var int
     */
    public $countOrders;

    /**
     * @var float|null
     */
    public $captainOrderCost;

    /**
     * @var int|null
     */
    public $isCashPaymentConfirmedByStore;

    /**
     * @var DateTime|null
     */
    public $isCashPaymentConfirmedByStoreUpdateDate;

    /**
     * @var float|null
     */
    public $storeBranchToClientDistance;
}
