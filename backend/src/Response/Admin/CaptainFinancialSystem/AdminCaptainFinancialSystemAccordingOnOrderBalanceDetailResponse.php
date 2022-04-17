<?php

namespace App\Response\Admin\CaptainFinancialSystem;

class AdminCaptainFinancialSystemAccordingOnOrderBalanceDetailResponse
{    
    public string|null $categoryName;

    public float|null $countKilometersFrom;
  
    public float|null $countKilometersTo;

    public float|null $amount;

    public float|null $bounce;

    public int|null $bounceCountOrdersInMonth;

    public float|null $captainTotalCategory;

    public int|null $contOrderCompleted;

    public int|null $countOfOrdersLeft;

    public string|null $message;

    public float|null $captainBounce;

    public float|null $financialDues;

    public float|null $sumPayments;

    public float|null $total;

    public bool|null $advancePayment;
}
