<?php

namespace App\Request\Subscription;

class CalculateCostDeliveryOrderRequest
{
    private $storeBranchToClientDistance;

    private $storeOwner;


    /**
     * Get the value of storeOwner
     */ 
    public function getStoreOwner()
    {
        return $this->storeOwner;
    }

    /**
     * Set the value of storeOwner
     *
     * @return  self
     */ 
    public function setStoreOwner($storeOwner)
    {
        $this->storeOwner = $storeOwner;

        return $this;
    }

    /**
     * Get the value of storeBranchToClientDistance
     */ 
    public function getStoreBranchToClientDistance()
    {
        return $this->storeBranchToClientDistance;
    }

    /**
     * Set the value of storeBranchToClientDistance
     *
     * @return  self
     */ 
    public function setStoreBranchToClientDistance($storeBranchToClientDistance)
    {
        $this->storeBranchToClientDistance = $storeBranchToClientDistance;

        return $this;
    }
}
