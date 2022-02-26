<?php

namespace App\Request\Subscription;

class SubscriptionDetailsCreateRequest
{
    private $storeOwner;

    private $lastSubscription;

    private $remainingOrders;

    private $remainingCars;

    private $type;

    private $remainingTime;

    private $status;

    /**
     * @param mixed $storeOwner
     */
    public function setStoreOwner($storeOwner): void
    {
        $this->storeOwner = $storeOwner;
    }

     /**
     * @return mixed
     */
    public function getStoreOwner()
    {
        return $this->storeOwner;
    }

    /**
     * Get the value of lastSubscription
     */ 
    public function getLastSubscription()
    {
        return $this->lastSubscription;
    }

    /**
     * Set the value of lastSubscription
     *
     * @return  self
     */ 
    public function setLastSubscription($lastSubscription)
    {
        $this->lastSubscription = $lastSubscription;

        return $this;
    }

    /**
     * Get the value of remainingOrders
     */ 
    public function getRemainingOrders()
    {
        return $this->remainingOrders;
    }

    /**
     * Set the value of remainingOrders
     *
     * @return  self
     */ 
    public function setRemainingOrders($remainingOrders)
    {
        $this->remainingOrders = $remainingOrders;

        return $this;
    }

    /**
     * Get the value of remainingCars
     */ 
    public function getRemainingCars()
    {
        return $this->remainingCars;
    }

    /**
     * Set the value of remainingCars
     *
     * @return  self
     */ 
    public function setRemainingCars($remainingCars)
    {
        $this->remainingCars = $remainingCars;

        return $this;
    }

    /**
     * Get the value of type
     */ 
    public function getType()
    {
        return $this->type;
    }

    /**
     * Set the value of type
     *
     * @return  self
     */ 
    public function setType($type)
    {
        $this->type = $type;

        return $this;
    }

    /**
     * Get the value of remainingTime
     */ 
    public function getRemainingTime()
    {
        return $this->remainingTime;
    }

    /**
     * Set the value of remainingTime
     *
     * @return  self
     */ 
    public function setRemainingTime($remainingTime)
    {
        $this->remainingTime = $remainingTime;

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
