<?php

namespace App\Response\Admin\StoreOwnerBranch;

class StoreOwnerBranchGetForAdminResponse
{
    public int $id;

    public array $location;

    /**
     * @var string|null
     */
    public $city;

    /**
     * @var string|null
     */
    public $name;

    /**
     * @var bool|null
     */
    public $isActive;

    /**
     * @var string|null
     */
    public $branchPhone;
}
