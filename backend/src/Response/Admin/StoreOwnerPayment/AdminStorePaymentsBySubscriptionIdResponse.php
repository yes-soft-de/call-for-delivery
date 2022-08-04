<?php

namespace App\Response\Admin\StoreOwnerPayment;
use DateTime;
use OpenApi\Annotations as OA;

class AdminStorePaymentsBySubscriptionIdResponse
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
     * @var null|string
     */
    public $note;
}
