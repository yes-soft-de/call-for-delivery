<?php

namespace App\Request\Admin\Subscription;

class AdminCreateStoreSubscriptionRequest
{
    private int $storeProfileId;

    private int $packageId;

    private string|null $note = null;

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

    /**
     * Get the value of packageId
     */ 
    public function getPackageId()
    {
        return $this->packageId;
    }

    /**
     * Set the value of packageId
     *
     * @return  self
     */ 
    public function setPackageId($packageId)
    {
        $this->packageId = $packageId;

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
