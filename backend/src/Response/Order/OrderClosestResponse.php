<?php

namespace App\Response\Order;

class OrderClosestResponse
{
    public $id;

    public $state;

    public $payment;

    public $orderCost;
  
    public $orderType;
   
    public $note;
   
    public $deliveryDate;
   
    public $createdAt;

    public $location;
  
    public $branchName;

    public string|null $usedAs;

    public string|null $roomId;

    public string $storeOwnerName;

    public float|null $rating;

    public array|null $subOrder;
}
