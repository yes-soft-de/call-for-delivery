<?php

namespace App\Response\StorePayment;

use OpenApi\Annotations as OA;

class StoreOwnerPaymentResponse
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
     * @var null|string
     */
    public $note;
}
