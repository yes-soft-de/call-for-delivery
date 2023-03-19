<?php

namespace App\Response\Subscription;

class CanCreateOrderResponse
{
    /**
     * @var bool|null
     */
    public $canCreateOrder;

    /**
     * @var string|null
     */
    public $subscriptionStatus;

    /**
     * @var string|null
     */
    public $percentageOfOrdersConsumed;

    /**
     * @var string|null
     */
    public $packageName;

    /**
     * @var int|null
     */
    public $packageType;
}
