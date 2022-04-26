<?php

namespace App\Response\Admin\StoreOwnerPayment;
use OpenApi\Annotations as OA;

class AdminStoreOwnerPaymentResponse
{
    /**
     * @var int
     */
    public $id;

    /**
     * @var float
     */
    public $amount;

    /**
     *
     * @OA\Property(type="array", property="date",
     *     @OA\Items(type="object"))
     *
     * @var array
     */
    public $date;

    /**
     * @var int
     */
    public $storeId;

    /**
     * @var string
     */
    public $storeOwnerName;

    /**
     * @var null|string
     */
    public $note;
}
