<?php

namespace App\Request\Subscription;

class SubscriptionCaptainOfferCreateRequest
{
    private $captainOffer;

    private $storeOwner;

    /**
     * Get the value of captainOffer
     */ 
    public function getCaptainOffer()
    {
        return $this->captainOffer;
    }

    /**
     * Set the value of captainOffer
     *
     * @return  self
     */ 
    public function setCaptainOffer($captainOffer)
    {
        $this->captainOffer = $captainOffer;

        return $this;
    }

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
}
