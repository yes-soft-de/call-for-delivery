<?php

namespace App\Response\Admin\Order;

use DateTime;
use OpenApi\Annotations as OA;

class StoreOrderFilterByAdminResponse
{
    public int $id;

    public string $state;

    public ?float $orderCost;

    public ?string $note;

    /**
     * @OA\Property(type="object", property="deliveryDate")
     */
    public DateTime $deliveryDate;

    /**
     * @OA\Property(type="object", property="createdAt")
     */
    public DateTime $createdAt;

    public ?float $kilometer;

    public int $countOrders;

    public ?float $storeBranchToClientDistance;

    /**
     * @OA\Property(type="array", property="externalDeliveredOrders",
     *     @OA\Items(type="object"))
     */
    public array $externalDeliveredOrders = [];
}
