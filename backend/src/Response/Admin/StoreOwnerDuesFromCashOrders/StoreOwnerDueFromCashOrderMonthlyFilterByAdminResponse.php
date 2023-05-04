<?php

namespace App\Response\Admin\StoreOwnerDuesFromCashOrders;

use OpenApi\Annotations as OA;

class StoreOwnerDueFromCashOrderMonthlyFilterByAdminResponse
{
    public int $id;

    public int $storeOwnerProfileId;

    public string $storeOwnerName;

    /**
     * @OA\Property(type="array", property="image",
     *     @OA\Items(type="object"))
     */
    public $image;

    public float $amount;

    public float $toBePaid;
}
