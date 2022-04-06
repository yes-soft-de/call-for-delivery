<?php

namespace App\Request\Admin\CaptainFinancialSystem;


class AdminCaptainFinancialSystemAccordingOnOrderCreateRequest
{
    private string $categoryName;
    
    private int $countKilometersFrom;

    private int $countKilometersTo;

    private float $amount;

    private float|null $bounce;
    
    private float|null $bounceCountOrdersInMonth;
}