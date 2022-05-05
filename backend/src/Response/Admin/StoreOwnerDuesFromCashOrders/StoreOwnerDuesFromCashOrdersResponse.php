<?php

namespace App\Response\Admin\StoreOwnerDuesFromCashOrders;

use OpenApi\Annotations as OA;

class StoreOwnerDuesFromCashOrdersResponse
{
   public int $id;

   public string $storeOwnerName;

   public int $orderId;

   public float $amount;

   public int $flag;
     /**
     * @OA\Property(type="object", property="createdAt")
     */
   public object $createdAt;
}
