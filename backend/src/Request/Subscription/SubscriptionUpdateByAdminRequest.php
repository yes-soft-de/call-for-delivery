<?php

namespace App\Request\Subscription;

class SubscriptionUpdateByAdminRequest
{
    private $id;

    private $package;

    private $startDate;

    private $endDate;


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
    public function setId($id)
    {
        $this->id = $id;

        return $this;
    }
}
