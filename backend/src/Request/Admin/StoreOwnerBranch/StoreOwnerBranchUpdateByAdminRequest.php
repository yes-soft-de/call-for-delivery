<?php

namespace App\Request\StoreOwnerBranch;

class StoreOwnerBranchUpdateByAdminRequest
{
    private $id;

    private $location = [];

    private $name;

    private $city;

    /**
     * Get the value of id
     */
    public function getId()
    {
        return $this->id;
    }
}
