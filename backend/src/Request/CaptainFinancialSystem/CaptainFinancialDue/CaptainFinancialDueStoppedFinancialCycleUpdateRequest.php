<?php

namespace App\Request\CaptainFinancialSystem\CaptainFinancialDue;

use DateTime;

class CaptainFinancialDueStoppedFinancialCycleUpdateRequest
{
    private int $id;

    private DateTime $endDate;

    //active = 1, inactive = 0
    private int $state;

    private bool $captainStoppedFinancialCycle;

    public function getId(): int
    {
        return $this->id;
    }

    public function setId(int $id): void
    {
        $this->id = $id;
    }

    public function setEndDate(DateTime $endDate): void
    {
        $this->endDate = $endDate;
    }

    public function setState(int $state): void
    {
        $this->state = $state;
    }

    public function setCaptainStoppedFinancialCycle(bool $captainStoppedFinancialCycle): void
    {
        $this->captainStoppedFinancialCycle = $captainStoppedFinancialCycle;
    }
}
