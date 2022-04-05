<?php

namespace App\Request\Admin\StoreOwnerPayment;
use App\Entity\StoreOwnerProfileEntity;

class AdminStoreOwnerPaymentUpdateRequest
{
    private int $id;

    private float $amount;

    private int|StoreOwnerProfileEntity $store;

    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set the value of id
     *
     * @return  self
     */ 
    public function setId(int $id)
    {
        $this->id = $id;

        return $this;
    }

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
