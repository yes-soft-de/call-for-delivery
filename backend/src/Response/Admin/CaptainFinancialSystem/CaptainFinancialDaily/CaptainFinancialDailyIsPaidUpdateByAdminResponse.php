<?php

namespace App\Response\Admin\CaptainFinancialSystem\CaptainFinancialDaily;

use DateTime;

class CaptainFinancialDailyIsPaidUpdateByAdminResponse
{
    public int $id;

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

    public DateTime $createdAt;

    public DateTime $updatedAt;
}
