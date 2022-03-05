<?php

namespace App\Request\Admin\Package;

class PackageCategoryUpdateRequest
{
    private int $id;

    private string $name;

    /**
     * @var string|null
     */
    private $description;

    /**
     * Get the value of id
     */ 
    public function getId(): int
    {
        return $this->id;
    }
}
