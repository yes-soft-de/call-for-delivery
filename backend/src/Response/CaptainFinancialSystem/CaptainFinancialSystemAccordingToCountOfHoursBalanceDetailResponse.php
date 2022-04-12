<?php

namespace App\Response\CaptainFinancialSystem;

class CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse
{
    public int $countOrders;
    
    public float $countOrdersMaxFromNineteen;
    
    public float $compensationForEveryOrder;

    public float $salary;

    public float $financialDues;

    public float $sumPayments;

    public float $total;

    public bool $advancePayment;
}
