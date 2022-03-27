<?php

namespace App\Response\Subscription;

class CanCreateOrderResponse
{
    public $canCreateOrder;
    public $subscriptionStatus;
  
    public float|null $percentageOfOrdersConsumed;
}
