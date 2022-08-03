<?php

namespace App\Response\Admin\CaptainFinancialSystem;

class AdminCaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse
{
    public float|null $salary;

    public float|null $monthCompensation;

    public int|null $countOverOrdersThanRequired;

    public float|null $bounce;

    public string|null $monthTargetSuccess;
   
    public float|null $financialDues;

    public float|null $total;

    public int|null $countOrdersCompleted;

    public string|null $dateFinancialCycleEnds;

    public float|null $advancePayment;

    public float|null $sumPayments;
    
    public float|null $amountForStore;

    public array $orders;

    public string|null $dateFinancialCycleStarts;
  
    public int $countOrdersMaxFromNineteen;
}
