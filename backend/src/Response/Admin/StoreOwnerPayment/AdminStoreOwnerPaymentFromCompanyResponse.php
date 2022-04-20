<?php

namespace App\Response\Admin\StoreOwnerPayment;

class AdminStoreOwnerPaymentFromCompanyResponse
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
    public $createdAt;

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
