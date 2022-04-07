<?php

namespace App\Response\Admin\StoreOwnerPayment;

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
