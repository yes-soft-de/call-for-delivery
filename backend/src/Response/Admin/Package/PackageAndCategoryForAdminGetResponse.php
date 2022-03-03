<?php

namespace App\Response\Admin\Package;

class PackageAndCategoryForAdminGetResponse
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
