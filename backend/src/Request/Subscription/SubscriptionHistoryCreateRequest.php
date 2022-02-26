<?php

namespace App\Request\Subscription;

class SubscriptionHistoryCreateRequest
{
    private $storeOwner;

    private $note;

    private $type;

    private $subscription;

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
     * Get the value of note
     */ 
    public function getNote()
    {
        return $this->note;
    }

    /**
     * Set the value of note
     *
     * @return  self
     */ 
    public function setNote($note)
    {
        $this->note = $note;

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
     * Get the value of subscription
     */ 
    public function getSubscription()
    {
        return $this->subscription;
    }

    /**
     * Set the value of subscription
     *
     * @return  self
     */ 
    public function setSubscription($subscription)
    {
        $this->subscription = $subscription;

        return $this;
    }
}
