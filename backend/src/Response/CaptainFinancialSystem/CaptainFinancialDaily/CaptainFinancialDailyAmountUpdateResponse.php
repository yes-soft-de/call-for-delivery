<?php

namespace App\Response\CaptainFinancialSystem\CaptainFinancialDaily;

class CaptainFinancialDailyAmountUpdateResponse
{
    // id of type big integer
    public string $id;

    public float $amount;

    // captain financial due which he/she had received before.
    public float $alreadyHadAmount;

    public int $financialSystemType;

    /**
     * @var int|null
     */
    public $financialSystemPlan;

    public int $isPaid;

    public bool $withBonus;

    /**
     * @var float|null
     */
    public $bonus;
}
