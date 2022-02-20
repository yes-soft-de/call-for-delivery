<?php

namespace App\Request\StoreOwnerBranch;

class StoreOwnerBranchDeleteRequest
{
    private $id;

    private $isActive;

    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }
}
