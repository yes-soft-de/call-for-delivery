<?php

namespace App\Request\Package;

class PackageUpdateRequest
{
    private $id;

    private $name;

    private $cost;

    private $note;

    private $carCount;

    private $city;

    private $orderCount;
    
    private $expired;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }
}