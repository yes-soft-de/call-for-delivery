<?php

namespace App\Request\Admin\CaptainFinancialSystem;


class AdminCaptainFinancialSystemAccordingToCountOfOrdersCreateRequest
{    
    private int $countOrdersInMonth;

    private float $salary;

    private float $monthCompensation;

    private float $bounceMaxCountOrdersInMonth;
    
    private float $bounceMinCountOrdersInMonth;
}