<?php

namespace App\Response\Package;

class PackageActiveResponse
{
    public $id;

    public $name;

    public $cost;

    public $note;

    public $carCount;

    public $city;

    public $orderCount;

    public $expired;

    public $status;
 
    public int|null $type;
   
    public float|null $geographicalRange;

    public  float|null $extraCost;
}
