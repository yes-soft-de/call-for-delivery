<?php

namespace App\Response\Subscription;

class RemainingOrdersResponse
{
    public $packageID;
    public $packageName;
    public $subscriptionId;
    public $remainingOrders;
    public $countOrdersDelivered;
    public $subscriptionStatus;
    public $subscriptionStartDate;
    public $subscriptionEndDate;
    public $packageCarCount;
    public $packageOrderCount;
    public $countCarsBusy;
    public $carsStatus;
}
