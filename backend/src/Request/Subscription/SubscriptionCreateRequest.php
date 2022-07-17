<?php

namespace App\Request\Subscription;

class SubscriptionCreateRequest
{
    private $storeOwner;

    private $package;

    private $startDate;

    private $endDate;

    private $status;

    private $isFuture;

    private $note;

    private $hasExtra;

    private $type;

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
     * @param mixed $status
     */
    public function setStatus($status): void
    {
        $this->status = $status;
    }

     /**
     * @return mixed
     */
    public function getStatus()
    {
        return $this->status;
    }
    /**
     * @param mixed $isFuture
     */
    public function setIsFuture($isFuture): void
    {
        $this->isFuture = $isFuture;
    }

     /**
     * @return mixed
     */
    public function getIsFuture()
    {
        return $this->isFuture;
    }

    /**
     * Get the value of package
     */ 
    public function getPackage()
    {
        return $this->package;
    }

    /**
     * Set the value of package
     *
     * @return  self
     */ 
    public function setPackage($package)
    {
        $this->package = $package;

        return $this;
    }

    /**
     * Get the value of hasExtra
     */ 
    public function getHasExtra()
    {
        return $this->hasExtra;
    }

    /**
     * Set the value of hasExtra
     *
     * @return  self
     */ 
    public function setHasExtra($hasExtra)
    {
        $this->hasExtra = $hasExtra;

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
}
