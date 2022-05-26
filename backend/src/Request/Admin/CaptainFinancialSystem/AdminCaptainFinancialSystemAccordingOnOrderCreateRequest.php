<?php

namespace App\Request\Admin\CaptainFinancialSystem;

class AdminCaptainFinancialSystemAccordingOnOrderCreateRequest
{
    private string $categoryName;
    
    private float $countKilometersFrom;

    private float $countKilometersTo;

    private float $amount;

    private float|null $bounce;
    
    private float|null $bounceCountOrdersInMonth;
}