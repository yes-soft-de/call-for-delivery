<?php

namespace App\Response\Admin\CaptainAmountFromOrderCash;

use OpenApi\Annotations as OA;

class CaptainAmountFromOrderCashResponse
{
   public int $id;

   public string $captainName;

   public int $orderId;

   public float $amount;

   public int $flag;
     /**
     * @OA\Property(type="object", property="createdAt")
     */
   public object $createdAt;
}
