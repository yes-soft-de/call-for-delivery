<?php

namespace App\Response\Order;

class OrderPendingResponse
{
    public int|null $id;

    public string|null $state;

    public string|null $payment;

    public float|null $orderCost;
  
    public int|null $orderType;
   
    public string|null $note;
   
    public object $deliveryDate;
   
    public object $createdAt;

    public array|null $location;
  
    public string|null $branchName;

    public string $storeOwnerName;

    public float|null $rating;
    
    public array|null $subOrder;

    public bool|null $orderIsMain;
}
