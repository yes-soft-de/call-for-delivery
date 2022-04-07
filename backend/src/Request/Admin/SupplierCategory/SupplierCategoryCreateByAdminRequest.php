<?php

namespace App\Request\Admin\SupplierCategory;

class SupplierCategoryCreateByAdminRequest
{
    private string $name;

    private ?string $description;

    private bool $status;

    /**
     * @var string|null
     */
    private $image;

    /**
     * @return string|null
     */
    public function getImage(): ?string
    {
        return $this->image;
    }
}
