<?php

namespace App\Request\Admin\CaptainPayment;

use App\Entity\CaptainEntity;

class AdminCaptainPaymentCreateRequest
{
    private float $amount;

    private int|CaptainEntity $captain;

    private string|null $note;

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
}
