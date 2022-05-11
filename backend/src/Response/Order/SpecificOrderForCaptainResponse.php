<?php

namespace App\Response\Order;

class SpecificOrderForCaptainResponse
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
  
    public $storeOwnerName;
  
    public $phone;
    
    public $roomId;
    
    public $location;

    public string $usedAs;

    public float|null $rating;

    public string|null $branchPhone;
 
    public string|null $ratingComment;

    public array|null $orderLogs;

    public $storeId;

    public int|null $paidToProvider;

    public array|null $subOrder;

    public bool|null $orderIsMain;
}
