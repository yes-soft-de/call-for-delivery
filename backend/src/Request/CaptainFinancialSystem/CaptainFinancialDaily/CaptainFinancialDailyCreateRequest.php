<?php

namespace App\Request\CaptainFinancialSystem\CaptainFinancialDaily;

use App\Entity\CaptainEntity;
use App\Entity\CaptainPaymentEntity;

class CaptainFinancialDailyCreateRequest
{
    /**
     * @var int|CaptainEntity
     */
    private $captainProfile;

    private float $amount;

    // captain financial due which he/she had received before.
    private float $alreadyHadAmount;

    private int $financialSystemType;

    private int $financialSystemPlan;

    private int $isPaid;

    private bool $withBonus;

    /**
     * @var float|null
     */
    private $bonus;

    /**
     * @var CaptainPaymentEntity|null
     */
    private $captainPayment;

    public function getCaptainProfile(): CaptainEntity|int
    {
        return $this->captainProfile;
    }

    public function setCaptainProfile(CaptainEntity|int $captainProfile): void
    {
        $this->captainProfile = $captainProfile;
    }

    public function getAmount(): float
    {
        return $this->amount;
    }

    public function setAmount(float $amount): void
    {
        $this->amount = $amount;
    }

    public function getAlreadyHadAmount(): float
    {
        return $this->alreadyHadAmount;
    }

    public function setAlreadyHadAmount(float $alreadyHadAmount): void
    {
        $this->alreadyHadAmount = $alreadyHadAmount;
    }

    public function getFinancialSystemType(): int
    {
        return $this->financialSystemType;
    }

    public function setFinancialSystemType(int $financialSystemType): void
    {
        $this->financialSystemType = $financialSystemType;
    }

    public function getFinancialSystemPlan(): int
    {
        return $this->financialSystemPlan;
    }

    public function setFinancialSystemPlan(int $financialSystemPlan): void
    {
        $this->financialSystemPlan = $financialSystemPlan;
    }

    public function getIsPaid(): int
    {
        return $this->isPaid;
    }

    public function setIsPaid(int $isPaid): void
    {
        $this->isPaid = $isPaid;
    }

    public function isWithBonus(): bool
    {
        return $this->withBonus;
    }

    public function setWithBonus(bool $withBonus): void
    {
        $this->withBonus = $withBonus;
    }

    public function getBonus(): ?float
    {
        return $this->bonus;
    }

    public function setBonus(?float $bonus): void
    {
        $this->bonus = $bonus;
    }

    public function getCaptainPayment(): ?CaptainPaymentEntity
    {
        return $this->captainPayment;
    }

    public function setCaptainPayment(?CaptainPaymentEntity $captainPayment): void
    {
        $this->captainPayment = $captainPayment;
    }
}
