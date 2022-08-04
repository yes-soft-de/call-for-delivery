<?php

namespace App\Response\Package;

class PackageResponse
{
    public $id;

    public $name;

    public $cost;

    public $note;

    public $carCount;

    public $city;

    public $orderCount;

    public $status;

    public $expired;
    
    public int|null $type;
   
    public float|null $geographicalRange;

    public  float|null $extraCost;
}
