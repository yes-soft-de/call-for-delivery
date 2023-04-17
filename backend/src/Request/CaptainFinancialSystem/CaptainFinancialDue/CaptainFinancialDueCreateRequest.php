<?php

namespace App\Request\CaptainFinancialSystem\CaptainFinancialDue;

use App\Entity\CaptainEntity;
use DateTime;

class CaptainFinancialDueCreateRequest
{
    private int $status;

    private float $amount;

    private DateTime $startDate;

    private DateTime $endDate;

    /**
     * @var float|null
     */
    private $amountForStore;

    /**
     * @var int|null
     */
    private $statusAmountForStore;

    /**
     * @var int|CaptainEntity
     */
    private $captain;

    //active = 1, inactive = 0
    private int $state;

    public function setStatus(int $status): void
    {
        $this->status = $status;
    }

    public function setAmount(float $amount): void
    {
        $this->amount = $amount;
    }

    public function setStartDate(DateTime $startDate): void
    {
        $this->startDate = $startDate;
    }

    public function setEndDate(DateTime $endDate): void
    {
        $this->endDate = $endDate;
    }

    public function setAmountForStore(?float $amountForStore): void
    {
        $this->amountForStore = $amountForStore;
    }

    public function setStatusAmountForStore(?int $statusAmountForStore): void
    {
        $this->statusAmountForStore = $statusAmountForStore;
    }

    public function setCaptain(CaptainEntity|int $captain): void
    {
        $this->captain = $captain;
    }

    public function setState(int $state): void
    {
        $this->state = $state;
    }
}
