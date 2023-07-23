<?php

namespace App\Request\CaptainFinancialDemand;

use App\Entity\CaptainEntity;
use App\Entity\CaptainFinancialDuesEntity;

class CaptainFinancialDemandCreateRequest
{
    private int|CaptainEntity $captain;

    private int|CaptainFinancialDuesEntity $captainFinancialDueId;

    public function getCaptain(): CaptainEntity|int
    {
        return $this->captain;
    }

    public function setCaptain(CaptainEntity|int $captain): void
    {
        $this->captain = $captain;
    }

    public function getCaptainFinancialDueId(): CaptainFinancialDuesEntity|int
    {
        return $this->captainFinancialDueId;
    }

    public function setCaptainFinancialDueId(CaptainFinancialDuesEntity|int $captainFinancialDueId): void
    {
        $this->captainFinancialDueId = $captainFinancialDueId;
    }
}
