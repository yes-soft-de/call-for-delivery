<?php

namespace App\Response\Package;

class PackageCategoriesAndPackagesResponse
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
     * @var string|null
     */
    public $description;

    /**
     * @var array|null
     */
    public $packages;
}
