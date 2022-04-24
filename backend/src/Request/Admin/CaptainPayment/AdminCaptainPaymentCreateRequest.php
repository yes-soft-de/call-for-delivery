<?php

namespace App\Request\Admin\CaptainPayment;

use App\Entity\CaptainEntity;

class AdminCaptainPaymentCreateRequest
{
    private float $amount;

    private int|CaptainEntity $captain;

    private string|null $note;

    private int $captainFinancialDuesId;

    private int $status;

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
    public function setCaptain(CaptainEntity $captain)
    {
        $this->captain = $captain;

        return $this;
    }

    /**
     * Get the value of captainFinancialDuesId
     */ 
    public function getCaptainFinancialDuesId()
    {
        return $this->captainFinancialDuesId;
    }

    /**
     * Set the value of captainFinancialDuesId
     *
     * @return  self
     */ 
    public function setCaptainFinancialDuesId($captainFinancialDuesId)
    {
        $this->captainFinancialDuesId = $captainFinancialDuesId;

        return $this;
    }

    /**
     * Get the value of status
     */ 
    public function getStatus()
    {
        return $this->status;
    }

    /**
     * Set the value of status
     *
     * @return  self
     */ 
    public function setStatus($status)
    {
        $this->status = $status;

        return $this;
    }
}
