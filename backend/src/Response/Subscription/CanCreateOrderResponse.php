<?php

namespace App\Response\Subscription;

class CanCreateOrderResponse
{
    public bool|null $canCreateOrder;
   
    public string|null $subscriptionStatus;
  
    public string|null $percentageOfOrdersConsumed;
    
    public string|null $packageName;
}
