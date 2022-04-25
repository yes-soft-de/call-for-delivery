<?php

namespace App\Response\Admin\CaptainFinancialSystem;

use DateTime;
use OpenApi\Annotations as OA;

class AdminCaptainFinancialDuesResponse
{
    public int $id;
    
    public int $status;

    public float $amount;

    public float $amountForStore;

    public int $statusAmountForStore;
    
    public DateTime $startDate;

    public DateTime $endDate;

    public int $captainId;
    
    public string $captainName;
   
    /**
     * @OA\Property(type="array", property="paymentsToCaptain",
     *     @OA\Items(type="object"))
     */
    public array $paymentsToCaptain;

    /**
     * @OA\Property(type="array", property="total",
     *     @OA\Items(type="object"))
     */
    public array $total;
}
