<?php

namespace App\Response\Admin\CaptainFinancialSystem;

class AdminCaptainFinancialSystemAccordingToCountOfOrdersCreateResponse
{
    public int $id;
    
    public int $countOrdersInMonth;

    public float $salary;

    public float $monthCompensation;

    public float $bounceMaxCountOrdersInMonth;
    
    public float $bounceMinCountOrdersInMonth;
}