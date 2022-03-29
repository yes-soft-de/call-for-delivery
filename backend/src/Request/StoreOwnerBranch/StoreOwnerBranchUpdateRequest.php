<?php

namespace App\Request\StoreOwnerBranch;

class StoreOwnerBranchUpdateRequest
{
    private $id;
   
    private $location = [];

    private $name;

    private $city;

    private string|null $branchPhone;

    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }
}
