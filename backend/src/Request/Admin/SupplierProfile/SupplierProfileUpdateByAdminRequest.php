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

    /**
     * @var object|null
     */
    private $location;

    /**
     * @var string|null
     */
    private $bankName;

    /**
     * @var string|null
     */
    private $bankAccountNumber;

    /**
     * @var string|null
     */
    private $stcPay;

    /**
     * @var array|null
     */
    private $supplierCategories;

    /**
     * takes 'true' when we want to store all supplier categories in supplierCategories field.
     * @var bool|null
     */
    private $allSupplierCategories;

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

    public function getSupplierCategories(): ?array
    {
        return $this->supplierCategories;
    }

    public function setSupplierCategories(?array $supplierCategories): void
    {
        $this->supplierCategories = $supplierCategories;
    }

    public function getAllSupplierCategories(): ?bool
    {
        return $this->allSupplierCategories;
    }
}
