<?php

namespace App\Response\Admin\Order;

use DateTime;
use OpenApi\Annotations as OA;

class StoreOrderFilterByAdminResponse
{
    public int $id;

    public string $state;

    //public string $payment;

    public ?float $orderCost;

    //public int $orderType;

    public ?string $note;

    /**
     * @OA\Property(type="object", property="deliveryDate")
     */
    public DateTime $deliveryDate;

    /**
     * @OA\Property(type="object", property="createdAt")
     */
    public DateTime $createdAt;

//    /**
//     * @OA\Property(type="object", property="updatedAt")
//     */
//    public DateTime|null $updatedAt;

    public ?float $kilometer;

    //public ?int $storeOrderDetailsId;

//    /**
//     * @OA\Property(type="array", property="destination",
//     *     @OA\Items(type="object"))
//     */
//    public array|null $destination;

    //public ?string $recipientName;

    //public ?string $recipientPhone;

    //public ?string $detail;

    //public ?int $storeOwnerBranchId;

//    /**
//     * @OA\Property(type="object", property="location")
//     */
//    public array|null $location;

    //public ?string $branchName;

    //public ?int $imageId;

//    /**
//     * @OA\Property(type="object", property="images")
//     */
//    public array|null $images;

    public int $countOrders;

    //public ?float $captainOrderCost;

    //public ?int $isCashPaymentConfirmedByStore;

    //public ?DateTime $isCashPaymentConfirmedByStoreUpdateDate;

    public ?float $storeBranchToClientDistance;

    //public ?int $captainProfileId;

    /**
     * @OA\Property(type="array", property="externalDeliveredOrders",
     *     @OA\Items(type="object"))
     */
    public array $externalDeliveredOrders = [];
}
