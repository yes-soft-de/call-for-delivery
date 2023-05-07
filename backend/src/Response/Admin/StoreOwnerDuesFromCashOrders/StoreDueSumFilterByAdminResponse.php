<?php

namespace App\Response\Admin\StoreOwnerDuesFromCashOrders;

use OpenApi\Annotations as OA;

class StoreDueSumFilterByAdminResponse
{
    public int $id;

    /**
     * @var int|null
     */
    public $storeOwnerProfileId;

    /**
     * @var string|null
     */
    public $storeOwnerName;

    /**
     * @OA\Property(type="array", property="image",
     *     @OA\Items(type="object"))
     */
    public $image;

    public float $amountSum;

    public float $toBePaid;
}
