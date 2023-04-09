<?php

namespace App\Response\CaptainFinancialSystem;

class CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse
{
    public float $countOrders;
    
    public float $countOrdersMaxFromNineteen;
    
    public float|null $compensationForEveryOrder;

    public float|null $salary;

    public float|null $financialDues;

    public float|null $sumPayments;

    public float|null $total;

    public bool $advancePayment;
    
    public float $amountForStore;

    public string|null $dateFinancialCycleStarts;

    public string|null $dateFinancialCycleEnds;

    public float $countOrdersWithoutDistance;

    public int $captainFinancialSystemType;
}
