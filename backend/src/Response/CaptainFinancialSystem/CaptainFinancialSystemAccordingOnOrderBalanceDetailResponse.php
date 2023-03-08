<?php

namespace App\Response\CaptainFinancialSystem;

class CaptainFinancialSystemAccordingOnOrderBalanceDetailResponse
{    
    public string|null $categoryName;

    public float|null $countKilometersFrom;
  
    public float|null $countKilometersTo;

    public float|null $amount;

    public float|null $bounce;

    public int|null $bounceCountOrdersInMonth;

    public float|null $captainTotalCategory;

    public float|null $contOrderCompleted;

    public float|null $countOfOrdersLeft;

    public string|null $message;

    public float|null $captainBounce;

    public float|null $financialDues;

    public float|null $sumPayments;

    public float|null $total;

    public bool|null $advancePayment;

    public float $amountForStore;
}
