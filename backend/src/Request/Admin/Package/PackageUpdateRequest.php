<?php

namespace App\Request\Admin\Package;

class PackageUpdateRequest
{
    private int $id;

    private string $name;

    /**
     * @var float|null
     */
    private $cost;

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
   
    private int $type;

    private float $geographicalRange;

    private float $extraCost;

    public function getId(): int
    {
        return $this->id;
    }
}