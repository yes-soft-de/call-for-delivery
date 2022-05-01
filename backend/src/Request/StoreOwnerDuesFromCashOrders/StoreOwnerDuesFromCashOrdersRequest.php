<?php

namespace App\Request\StoreOwnerDuesFromCashOrders;

use App\Entity\OrderEntity;
use App\Entity\StoreOwnerProfileEntity;

class StoreOwnerDuesFromCashOrdersRequest
{
    private OrderEntity $orderId;

    private StoreOwnerProfileEntity $store;

    private int $flag;
    
    private float $amount;


    /**
     * Get the value of store
     */ 
    public function getStore()
    {
        return $this->store;
    }

    /**
     * Set the value of store
     *
     * @return  self
     */ 
    public function setStore($store)
    {
        $this->store = $store;

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
}