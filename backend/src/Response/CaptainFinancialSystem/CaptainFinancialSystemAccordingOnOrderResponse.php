<?php

namespace App\Response\CaptainFinancialSystem;

class CaptainFinancialSystemAccordingOnOrderResponse
{
    public int $id;
    
    public string $categoryName;
    
    public int $countKilometersFrom;

    public int $countKilometersTo;

    public float $amount;

    public float|null $bounce;
    
    public float|null $bounceCountOrdersInMonth;
}
