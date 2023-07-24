<?php

namespace App\Request\CaptainFinancialSystem;

use App\Entity\CaptainEntity;

class CaptainFinancialSystemDetailRequest
{    
    private int $captainFinancialSystemType;

    private int $captainFinancialSystemId;

    private CaptainEntity|int $captain;

    /**
     * Get the value of captain
     */ 
    public function getCaptain()
    {
        return $this->captain;
    }

    /**
     * Set the value of captain
     *
     * @return  self
     */ 
    public function setCaptain(int|CaptainEntity $captain)
    {
        $this->captain = $captain;

        return $this;
    }

    public function setCaptainFinancialSystemType(int $captainFinancialSystemType): void
    {
        $this->captainFinancialSystemType = $captainFinancialSystemType;
    }

    public function setCaptainFinancialSystemId(int $captainFinancialSystemId): void
    {
        $this->captainFinancialSystemId = $captainFinancialSystemId;
    }
}
