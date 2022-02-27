<?php

namespace App\Response\Subscription;

class RemainingOrdersResponse
{
    public $id;
    public $packageId;
    public $packageName;
    public $remainingOrders;
    public $remainingCars;
    public $status;
    public $startDate;
    public $endDate;
    public $packageCarCount;
    public $packageOrderCount;
}
