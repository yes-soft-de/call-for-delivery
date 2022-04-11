<?php

namespace App\Request\CaptainPayment;

class CaptainPaymentFilterRequest
{
    private string $userId;

    private string|null $fromDate;

    private string|null $toDate;

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
    public function setFromDate(string|null $fromDate)
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
    public function setToDate(string|null $toDate)
    {
        $this->toDate = $toDate;

        return $this;
    }

    /**
     * Get the value of userId
     */ 
    public function getUserId()
    {
        return $this->userId;
    }

    /**
     * Set the value of userId
     *
     * @return  self
     */ 
    public function setUserId($userId)
    {
        $this->userId = $userId;

        return $this;
    }
}
