<?php

namespace App\Response\CaptainFinancialSystem\CaptainFinancialDaily;

use DateTime;

class CaptainFinancialDailyAmountGetForCaptainResponse
{
    public int $id;

    public float $amount;

    // captain financial due which he/she had received before.
    public float $alreadyHadAmount;

    public int $isPaid;

    public bool $withBonus;

    public float $bonus;

    public DateTime $updatedAt;
}
