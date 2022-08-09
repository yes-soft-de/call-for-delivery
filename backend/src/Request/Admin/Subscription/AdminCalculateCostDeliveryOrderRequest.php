<?php

namespace App\Request\Admin\Subscription;

class AdminCalculateCostDeliveryOrderRequest
{
    private $storeBranchToClientDistance;

    private $storeOwnerProfileId;

   
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

    /**
     * Get the value of storeOwnerProfileId
     */ 
    public function getStoreOwnerProfileId()
    {
        return $this->storeOwnerProfileId;
    }

    /**
     * Set the value of storeOwnerProfileId
     *
     * @return  self
     */ 
    public function setStoreOwnerProfileId($storeOwnerProfileId)
    {
        $this->storeOwnerProfileId = $storeOwnerProfileId;

        return $this;
    }
}
