<?php

namespace App\Request\Admin\StoreOwnerPayment;

use App\Entity\StoreOwnerProfileEntity;

class AdminStoreOwnerPaymentCreateRequest
{
    private float $amount;

    private int|StoreOwnerProfileEntity $store;

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
}
