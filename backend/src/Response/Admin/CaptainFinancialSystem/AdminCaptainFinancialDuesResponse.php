<?php

namespace App\Response\Admin\CaptainFinancialSystem;

use DateTime;

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
}
