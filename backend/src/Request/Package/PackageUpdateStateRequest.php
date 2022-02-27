<?php

namespace App\Request\Package;

class PackageUpdateStateRequest
{
    private $id;

    private $name;

    private $cost;

    private $note;

    private $carCount;

    private $city;

    private $orderCount;

    private $status;
    
    private $expired;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }
}