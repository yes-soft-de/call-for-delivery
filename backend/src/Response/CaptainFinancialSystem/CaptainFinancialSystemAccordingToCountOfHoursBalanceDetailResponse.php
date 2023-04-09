<?php

namespace App\Response\CaptainFinancialSystem;

class CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse
{
    public float $countOrders;
    
    public float $countOrdersMaxFromNineteen;

    /**
     * @var float|null
     */
    public $compensationForEveryOrder;

    /**
     * @var float|null
     */
    public $salary;

    /**
     * @var float|null
     */
    public $financialDues;

    /**
     * @var float|null
     */
    public $sumPayments;

    /**
     * @var float|null
     */
    public $total;

    public int $advancePayment;
    
    public float $amountForStore;

    /**
     * @var string|null
     */
    public $dateFinancialCycleStarts;

    /**
     * @var string|null
     */
    public $dateFinancialCycleEnds;

    public float $countOrdersWithoutDistance;

    public int $captainFinancialSystemType;
}
