<?php

namespace App\Request\Admin\CaptainPayment;

use App\Entity\AdminProfileEntity;
use App\Entity\CaptainEntity;

class AdminCaptainPaymentCreateRequest
{
    private float $amount;

    private int|CaptainEntity $captain;

    private string|null $note;

    private int $captainFinancialDuesId;

//    private int $status;

    private string $paymentId = "";

    private int $paymentGetaway;

    private int $paymentFor;

    private int $paymentType;

    private int|AdminProfileEntity $createdByAdmin;

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

//    public function getStatus()
//    {
//        return $this->status;
//    }
//
//    public function setStatus($status)
//    {
//        $this->status = $status;
//    }

    public function setPaymentId(string $paymentId): void
    {
        $this->paymentId = $paymentId;
    }

    public function getCreatedByAdmin(): AdminProfileEntity|int
    {
        return $this->createdByAdmin;
    }

    public function setCreatedByAdmin(int|AdminProfileEntity $createdByAdmin): void
    {
        $this->createdByAdmin = $createdByAdmin;
    }
}
