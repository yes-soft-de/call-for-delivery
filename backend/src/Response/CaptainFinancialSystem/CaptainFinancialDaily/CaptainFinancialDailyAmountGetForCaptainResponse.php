<?php

namespace App\Response\CaptainFinancialSystem\CaptainFinancialDaily;

use DateTime;

class CaptainFinancialDailyAmountGetForCaptainResponse
{
    public int $id = 0;

    public float $amount = 0.0;

    // captain financial due which he/she had received before.
    public float $alreadyHadAmount = 0.0;

    public int $isPaid = 176;

    public bool $withBonus = false;

    public float $bonus = 0.0;

    /**
     * @var DateTime|null
     */
    public $updatedAt;
}
