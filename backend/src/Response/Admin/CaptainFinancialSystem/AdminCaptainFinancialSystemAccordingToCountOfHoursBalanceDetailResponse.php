<?php

namespace App\Response\Admin\CaptainFinancialSystem;

class AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse
{
    public float $countOrders;
    
    public float $countOrdersMaxFromNineteen;
    
    public float|null $compensationForEveryOrder;

    public float|null $salary;

    public float|null $financialDues;

    public float|null $sumPayments;

    public float|null $total;

    public int $advancePayment;

    public float|null $amountForStore;
    
    public array $orders;
    
    public string|null $dateFinancialCycleStarts;

    public string|null $dateFinancialCycleEnds;

    public float $countOrdersWithoutDistance;
}
