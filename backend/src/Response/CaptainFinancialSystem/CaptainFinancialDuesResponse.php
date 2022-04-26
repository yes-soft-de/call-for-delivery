<?php

namespace App\Response\CaptainFinancialSystem;

use DateTime;
use OpenApi\Annotations as OA;

class CaptainFinancialDuesResponse
{
    public int $id;
    
    public int $status;

    public float $amount;

    public float $amountForStore;

    public int $statusAmountForStore;
    
    public DateTime $startDate;

    public DateTime $endDate;
    
    /**
     * @OA\Property(type="array", property="paymentsFromCompany",
     *     @OA\Items(type="object"))
     */
    public array $paymentsFromCompany;
    
     /**
     * @OA\Property(type="array", property="total",
     *     @OA\Items(type="object"))
     */
    public array $total;
}
