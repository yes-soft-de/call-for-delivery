<?php

namespace App\Request\Admin\SupplierProfile;

use App\Entity\SupplierCategoryEntity;

class SupplierProfileUpdateByAdminRequest
{
    private int $id;

    private string $supplierName;

    private int|SupplierCategoryEntity $supplierCategory;

    /**
     * @var string|null
     */
    private $phone;

    /**
     * @var array|null
     */
    private $images;

    public function getId(): int
    {
        return $this->id;
    }

    public function getSupplierCategory(): int|SupplierCategoryEntity
    {
        return $this->supplierCategory;
    }

    public function setSupplierCategory(int|SupplierCategoryEntity $supplierCategory): void
    {
        $this->supplierCategory = $supplierCategory;
    }

    public function setImages(?array $images): void
    {
        $this->images = $images;
    }

    /**
     * @return array|null
     */
    public function getImages(): ?array
    {
        return $this->images;
    }
}
