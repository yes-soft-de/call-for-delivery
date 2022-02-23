<?php

namespace App\Request\Subscription;

class SubscriptionUpdateIsFutureRequest
{
    private $id;

    private $isFuture;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }


    /**
     * Get the value of isFuture
     */ 
    public function getIsFuture()
    {
        return $this->isFuture;
    }

    /**
     * Set the value of isFuture
     *
     * @return  self
     */ 
    public function setIsFuture($isFuture)
    {
        $this->isFuture = $isFuture;

        return $this;
    }
}
