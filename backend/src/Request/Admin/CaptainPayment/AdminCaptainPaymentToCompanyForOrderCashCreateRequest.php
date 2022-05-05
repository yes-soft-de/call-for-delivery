<?php

namespace App\Request\Admin\CaptainPayment;

use App\Entity\CaptainEntity;

class AdminCaptainPaymentToCompanyForOrderCashCreateRequest
{
    private float $amount;

    private int|CaptainEntity $captain;

    private string|null $note;

    private string $fromDate;

    private string $toDate;


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
     * Get the value of fromDate
     */ 
    public function getFromDate()
    {
        return $this->fromDate;
    }

    /**
     * Set the value of fromDate
     *
     * @return  self
     */ 
    public function setFromDate($fromDate)
    {
        $this->fromDate = $fromDate;

        return $this;
    }

    /**
     * Get the value of toDate
     */ 
    public function getToDate()
    {
        return $this->toDate;
    }

    /**
     * Set the value of toDate
     *
     * @return  self
     */ 
    public function setToDate($toDate)
    {
        $this->toDate = $toDate;

        return $this;
    }
}
