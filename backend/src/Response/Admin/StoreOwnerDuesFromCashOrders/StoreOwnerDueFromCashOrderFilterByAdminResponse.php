<?php

namespace App\Response\Admin\StoreOwnerDuesFromCashOrders;

use OpenApi\Annotations as OA;

class StoreOwnerDueFromCashOrderFilterByAdminResponse
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

    /**
     * @OA\Property(type="array", property="paymentFromCompanyToStore",
     *     @OA\Items(type="object"))
     */
    public $paymentFromCompanyToStore;

    // 1: paid. 2: not paid.
    public int $flag;
}
