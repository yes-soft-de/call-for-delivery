<?php

namespace App\Request\CaptainFinancialSystem\CaptainFinancialDaily;

class CaptainFinancialDailyAmountUpdateRequest
{
    private int $id;

    private float $amount;

    // captain financial due which he/she had received before.
    private float $alreadyHadAmount;

    private bool $withBonus;

    /**
     * @var float|null
     */
    private $bonus;

    public function getId(): int
    {
        return $this->id;
    }

    public function setId(int $id): void
    {
        $this->id = $id;
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
}
