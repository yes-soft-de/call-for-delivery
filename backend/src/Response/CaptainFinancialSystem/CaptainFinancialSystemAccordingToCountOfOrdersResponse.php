<?php

namespace App\Response\CaptainFinancialSystem;

class CaptainFinancialSystemAccordingToCountOfOrdersResponse
{
    public int $id;
    
    public int $countOrdersInMonth;

    public float $salary;

    public float $monthCompensation;

    public float $bounceMaxCountOrdersInMonth;
    
    public float $bounceMinCountOrdersInMonth;
}