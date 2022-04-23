<?php

namespace App\Response\CaptainFinancialSystem;

use DateTime;

class CaptainFinancialDuesResponse
{
    public int $id;
    
    public int $status;

    public float $amount;
    
    public DateTime $startDate;

    public DateTime $endDate;
}
