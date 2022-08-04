<?php

namespace App\Response\Admin\StoreOwnerPayment;
use DateTime;
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
     * @var DateTime
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
