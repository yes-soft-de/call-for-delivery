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

    public float|null $captainOrderCost;
    
    public array|null $orderLogs;

    public int|null $paidToProvider;

    public float|null $kilometer;

    public null|array $captain;

    public null|int $isHide;

    public null|bool $orderIsMain;

    public array|null $subOrder;

    public array|null $filePdf;

    public float|null $storeBranchToClientDistance;

    public int|null $isCaptainPaidToProvider;

    public object|null $dateCaptainPaidToProvider;
}
