<?php

namespace App\Response\Admin\Order;

use DateTime;
use OpenApi\Annotations as OA;

class OrderByIdGetForAdminResponse
{
    public int $id;

    public string $state;

    public string $payment;

    public ?float $orderCost;

    public int $orderType;

    /**
     * @OA\Property(type="array", property="orderLogs",
     *     @OA\Items(type="object"))
     */
    public $orderLogs;

    public ?string $note;

    public DateTime $deliveryDate;

    public DateTime $createdAt;

    public ?DateTime $updatedAt;

    public ?float $kilometer;

    public ?int $storeOrderDetailsId;

    /**
     * @OA\Property(type="object", property="destination")
     */
    public $destination;

    public ?string $recipientName;

    public ?string $recipientPhone;

    public ?string $detail;

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

    public ?int $captainUserId;

    public ?string $captainName;

    public ?string $phone;

    public ?int $paidToProvider;

    public int $storeOwnerId;

    public ?string $storeOwnerName;

    public ?float $captainOrderCost;

    public ?string $noteCaptainOrderCost;

    /**
     * @OA\Property(type="array", property="captain",
     *     @OA\Items(type="object"))
     */
    public $captain;

    /**
     * @OA\Property(type="array", property="filePdf",
     *     @OA\Items(type="string"))
     */
    public array|null $filePdf;

    public ?float $storeBranchToClientDistance;

    /**
     * @OA\Property(type="array", property="subOrder",
     *     @OA\Items(type="object"))
     */
    public $subOrder;

    public ?int $isCashPaymentConfirmedByStore;

    public ?DateTime $isCashPaymentConfirmedByStoreUpdateDate;

    public ?int $primaryOrderId;

    public ?int $costType;

    public ?int $packageId;

    public ?int $packageType;

    public ?float $deliveryCost;
}
