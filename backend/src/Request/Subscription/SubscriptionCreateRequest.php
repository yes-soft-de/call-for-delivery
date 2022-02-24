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
}
