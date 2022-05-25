<?php

namespace App\Request\CaptainAmountFromOrderCash;

use App\Entity\CaptainEntity;
use App\Entity\OrderEntity;

class CaptainAmountFromOrderCashRequest
{    
    private int|CaptainEntity $captain;

    private int|OrderEntity $orderId;

    private float $amount;
    
    private int $flag;

    private float $storeAmount;

    private string|null $captainNote;


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
    public function setCaptain($captain)
    {
        $this->captain = $captain;

        return $this;
    }

    /**
     * Get the value of orderId
     */ 
    public function getOrderId()
    {
        return $this->orderId;
    }

    /**
     * Set the value of orderId
     *
     * @return  self
     */ 
    public function setOrderId($orderId)
    {
        $this->orderId = $orderId;

        return $this;
    }

    /**
     * Get the value of amount
     */ 
    public function getAmount()
    {
        return $this->amount;
    }

    /**
     * Set the value of amount
     *
     * @return  self
     */ 
    public function setAmount($amount)
    {
        $this->amount = $amount;

        return $this;
    }

    /**
     * Get the value of flag
     */ 
    public function getFlag()
    {
        return $this->flag;
    }

    /**
     * Set the value of flag
     *
     * @return  self
     */ 
    public function setFlag($flag)
    {
        $this->flag = $flag;

        return $this;
    }

    /**
     * Get the value of storeAmount
     */ 
    public function getStoreAmount()
    {
        return $this->storeAmount;
    }

    /**
     * Set the value of storeAmount
     *
     * @return  self
     */ 
    public function setStoreAmount($storeAmount)
    {
        $this->storeAmount = $storeAmount;

        return $this;
    }

    /**
     * Get the value of captainNote
     */ 
    public function getCaptainNote()
    {
        return $this->captainNote;
    }

    /**
     * Set the value of captainNote
     *
     * @return  self
     */ 
    public function setCaptainNote($captainNote)
    {
        $this->captainNote = $captainNote;

        return $this;
    }
}
