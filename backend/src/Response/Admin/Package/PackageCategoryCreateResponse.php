<?php

namespace App\Response\Admin\Package;

class PackageCategoryCreateResponse
{
    public int $id;

    public string $name;

    /**
     * @var string|null
     */
    public $description;
}
