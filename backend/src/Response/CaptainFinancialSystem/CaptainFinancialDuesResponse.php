<?php

namespace App\Response\CaptainFinancialSystem;

use DateTime;

class CaptainFinancialDuesResponse
{
    public int $id;
    
    public int $status;

    public float $amount;

    public float $amountForStore;

    public int $statusAmountForStore;
    
    public DateTime $startDate;

    public DateTime $endDate;
    
    public array $paymentsFromCompany;
    
    public array $total;
}
