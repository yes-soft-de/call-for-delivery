<?php

namespace App\Request\Admin\Subscription;

class AdminExtraSubscriptionForDayRequest
{
    private int $storeProfileId;

    /**
     * Get the value of storeProfileId
     */ 
    public function getStoreProfileId()
    {
        return $this->storeProfileId;
    }

    /**
     * Set the value of storeProfileId
     *
     * @return  self
     */ 
    public function setStoreProfileId($storeProfileId)
    {
        $this->storeProfileId = $storeProfileId;

        return $this;
    }
}
