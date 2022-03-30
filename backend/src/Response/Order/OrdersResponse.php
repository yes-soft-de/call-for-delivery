<?php

namespace App\Response\Order;

class OrdersResponse
{
    public $id;

    public $state;

    public $payment;

    public $orderCost;
  
    public $orderType;
   
    public $note;
   
    public $deliveryDate;
   
    public $createdAt;
  
    public $storeOrderDetailsId;
  
    public $destination;
  
    public $recipientName;
  
    public $recipientPhone;
  
    public $detail;
  
    public $storeOwnerBranchId;
  
    public $branchName;

    public $images;

    public $captainUserId;
    
    public $roomId;

    public $captainName;

    public bool|null $isCaptainArrived;

    public object|null $dateCaptainArrived;
    
    public string|null $branchPhone;
    
    public string|null $attention;
}
