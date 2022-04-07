<?php

namespace App\Request\Admin\SupplierCategory;

class SupplierCategoryUpdateByAdminRequest
{
    private int $id;

    private string $name;

    /**
     * @var string|null
     */
    private $description;

    /**
     * @var string|null
     */
    private $image;

    /**
     * @return int
     */
    public function getId(): int
    {
        return $this->id;
    }

    /**
     * @return string|null
     */
    public function getImage(): ?string
    {
        return $this->image;
    }
}
