<?php

namespace App\Request\Admin\StoreOwnerPayment;

use App\Entity\StoreOwnerProfileEntity;

class AdminStoreOwnerPaymentCreateRequest
{
    private float $amount;

    private int|StoreOwnerProfileEntity $store;

    private string|null $note;

    private int|null $subscriptionId = 0;

    private int|null $subscriptionFlag = 0;

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
    public function setStore(StoreOwnerProfileEntity $store)
    {
        $this->store = $store;

        return $this;
    }

    /**
     * Get the value of subscriptionId
     */ 
    public function getSubscriptionId()
    {
        return $this->subscriptionId;
    }

    /**
     * Set the value of subscriptionId
     *
     * @return  self
     */ 
    public function setSubscriptionId($subscriptionId)
    {
        $this->subscriptionId = $subscriptionId;

        return $this;
    }

    /**
     * Get the value of subscriptionFlag
     */ 
    public function getSubscriptionFlag()
    {
        return $this->subscriptionFlag;
    }

    /**
     * Set the value of subscriptionFlag
     *
     * @return  self
     */ 
    public function setSubscriptionFlag($subscriptionFlag)
    {
        $this->subscriptionFlag = $subscriptionFlag;

        return $this;
    }
}
