<?php

namespace App\Request\StoreOwnerBranch;

class StoreOwnerBranchDeleteRequest
{
    private int $id;

    private bool $isActive;

    /**
     * Get the value of id
     */ 
    public function getId(): int
    {
        return $this->id;
    }
}
