<?php

namespace App\Request\Admin\StoreOwnerPayment;

use App\Entity\StoreOwnerProfileEntity;

class AdminStoreOwnerPaymentFromCompanyForOrderCashCreateRequest
{
    private float $amount;

    private int|StoreOwnerProfileEntity $store;

    private string|null $note;

    private string $fromDate;
   
    private string $toDate;

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
     * Get the value of fromDate
     */ 
    public function getFromDate()
    {
        return $this->fromDate;
    }

    /**
     * Set the value of fromDate
     *
     * @return  self
     */ 
    public function setFromDate($fromDate)
    {
        $this->fromDate = $fromDate;

        return $this;
    }

    /**
     * Get the value of toDate
     */ 
    public function getToDate()
    {
        return $this->toDate;
    }

    /**
     * Set the value of toDate
     *
     * @return  self
     */ 
    public function setToDate($toDate)
    {
        $this->toDate = $toDate;

        return $this;
    }
}
