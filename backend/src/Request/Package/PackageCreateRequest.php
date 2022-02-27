<?php

namespace App\Request\Package;

class PackageCreateRequest
{
    private $name;

    private $cost;

    private $note;

    private $carCount;

    private $city;

    private $orderCount;

    private $expired;

    private $status;

    private $packageCategory;

    /**
     * Get the value of packageCategory
     */ 
    public function getPackageCategory()
    {
        return $this->packageCategory;
    }

    /**
     * Set the value of packageCategory
     *
     * @return  self
     */ 
    public function setPackageCategory($packageCategory)
    {
        $this->packageCategory = $packageCategory;

        return $this;
    }
}
