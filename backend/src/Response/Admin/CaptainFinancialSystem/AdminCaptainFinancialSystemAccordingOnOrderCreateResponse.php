<?php

namespace App\Response\Admin\CaptainFinancialSystem;

class AdminCaptainFinancialSystemAccordingOnOrderCreateResponse
{
    public int $id;
    
    public string $categoryName;
    
    public float $countKilometersFrom;

    public float $countKilometersTo;

    public float $amount;

    public float|null $bounce;
    
    public float|null $bounceCountOrdersInMonth;
}