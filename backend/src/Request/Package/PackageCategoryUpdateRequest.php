<?php

namespace App\Request\Package;

class PackageCategoryUpdateRequest
{
    private $id;

    private $name;

    private $description;

    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }
}
