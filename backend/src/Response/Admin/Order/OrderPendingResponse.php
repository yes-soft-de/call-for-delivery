<?php

namespace App\Response\Admin\Order;

use DateTime;
use OpenApi\Annotations as OA;

class OrderPendingResponse
{
    public int|null $id;

    public string|null $state;

    public string|null $payment;

    public float|null $orderCost;
  
    public int|null $orderType;
   
    public string|null $note;
   
    public DateTime $deliveryDate;
   
    public DateTime $createdAt;

    /**
     * @OA\Property(type="array", property="location",
     *     @OA\Items(type="string"))
     */
    public $location;
  
    public string|null $branchName;

    public string $storeOwnerName;

    public float|null $rating;

    /**
     * @OA\Property(type="array", property="subOrder",
     *     @OA\Items(type="object"))
     */
    public $subOrder;

    public bool|null $orderIsMain;

    public int $isHide;
}
