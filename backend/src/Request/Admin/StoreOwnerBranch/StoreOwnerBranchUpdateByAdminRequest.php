<?php

namespace App\Request\Admin\StoreOwnerBranch;

class StoreOwnerBranchUpdateByAdminRequest
{
    private int $id;

    /**
     * @var array
     */
    private $location = [];

    /**
     * @var string|null
     */
    private $name;

    /**
     * @var string|null
     */
    private $city;

    /**
     * Get the value of id
     */
    public function getId(): int
    {
        return $this->id;
    }
}
