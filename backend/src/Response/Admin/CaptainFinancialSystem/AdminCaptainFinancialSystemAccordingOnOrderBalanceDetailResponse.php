<?php

namespace App\Response\Admin\CaptainFinancialSystem;

class AdminCaptainFinancialSystemAccordingOnOrderBalanceDetailResponse
{    
    public float|null $financialDues;

    public float|null $sumPayments;

    public float|null $total;

    public bool $advancePayment;
}
