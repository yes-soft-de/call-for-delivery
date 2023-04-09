<?php

namespace App\Response\CaptainFinancialSystem;

class CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse
{
    public float|null $salary;

    public float|null $monthCompensation;

    /**
     * @var float|null
     */
    public $countOverOrdersThanRequired;

    public float|null $bounce;

    public string|null $monthTargetSuccess;
   
    public float|null $financialDues;

    public float|null $total;

    /**
     * @var float|null
     */
    public $countOrdersCompleted;

    public string|null $dateFinancialCycleEnds;

    public float|null $advancePayment;

    public float|null $sumPayments;

    public float|null $amountForStore;

    public int|null $countOrdersInMonth;
  
    public string|null $dateFinancialCycleStarts;

    public float $countOrdersMaxFromNineteen;

    public float $countOrdersWithoutDistance;

    public int $captainFinancialSystemType;
}
