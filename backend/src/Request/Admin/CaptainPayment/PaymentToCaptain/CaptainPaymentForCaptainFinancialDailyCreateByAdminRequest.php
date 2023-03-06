<?php

namespace App\Request\Admin\CaptainPayment\PaymentToCaptain;

use App\Entity\CaptainEntity;
use App\Entity\CaptainFinancialDailyEntity;

class CaptainPaymentForCaptainFinancialDailyCreateByAdminRequest
{
    private float $amount;

    /**
     * @var CaptainEntity|null
     */
    private $captain;

    /**
     * @var string|null
     */
    private $note;

    /**
     * @var int|CaptainFinancialDailyEntity
     */
    private $captainFinancialDailyEntity;

    public function getCaptain(): ?CaptainEntity
    {
        return $this->captain;
    }

    public function setCaptain(?CaptainEntity $captain): void
    {
        $this->captain = $captain;
    }

    public function getCaptainFinancialDailyEntity(): CaptainFinancialDailyEntity|int
    {
        return $this->captainFinancialDailyEntity;
    }

    public function setCaptainFinancialDailyEntity(CaptainFinancialDailyEntity|int $captainFinancialDailyEntity): void
    {
        $this->captainFinancialDailyEntity = $captainFinancialDailyEntity;
    }

    public function getAmount(): float
    {
        return $this->amount;
    }
}
