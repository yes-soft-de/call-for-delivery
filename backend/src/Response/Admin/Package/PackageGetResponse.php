<?php

namespace App\Response\Admin\Package;

class PackageGetResponse
{
    /**
     * @var int|null
     */
    public $id;

    /**
     * @var string|null
     */
    public $name;

    /**
     * @var float|null
     */
    public $cost;

    /**
     * @var string|null
     */
    public $note;

    /**
     * @var int|null
     */
    public $carCount;

    /**
     * @var string|null
     */
    public $city;

    /**
     * @var int|null
     */
    public $orderCount;

    /**
     * @var string|null
     */
    public $status;

    /**
     * @var int|null
     */
    public $expired;
   
    /**
     * @var int|null
     */
    public $type;
   
    /**
     * @var float|null
     */
    public $geographicalRange;

    /**
     * @var float|null
     */
    public $extraCost;
}
