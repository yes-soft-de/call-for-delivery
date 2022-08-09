<?php

namespace App\Request\Admin\Package;

class PackageCreateRequest
{
    private string $name;

    private float $cost;

    /**
     * @var string|null
     */
    private $note;

    private int $carCount;

    /**
     * @var string|null
     */
    private $city;

    private int $orderCount;

    private int $expired;

    /**
     * @var string|null
     */
    private $status;

    private $packageCategory;

    private int $type;

    private float $geographicalRange;

    private float $extraCost;

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
