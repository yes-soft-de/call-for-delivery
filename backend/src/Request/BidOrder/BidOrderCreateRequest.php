<?php

namespace App\Request\BidOrder;

use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SupplierCategoryEntity;

class BidOrderCreateRequest
{
    /**
     * @var string|null
     */
    private $title;

    /**
     * @var string|null
     */
    private $description;

    /**
     * @var int|SupplierCategoryEntity
     */
    private $supplierCategory;

    /**
     * @var int|StoreOwnerProfileEntity
     */
    private $storeOwnerProfile;

    /**
     * @var array|null
     */
    private $imagesArray;

    public function getSupplierCategory(): int|SupplierCategoryEntity
    {
        return $this->supplierCategory;
    }

    public function setSupplierCategory(int|SupplierCategoryEntity $supplierCategory): void
    {
        $this->supplierCategory = $supplierCategory;
    }

    public function getStoreOwnerProfile(): int|StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfile;
    }

    public function setStoreOwnerProfile(int|StoreOwnerProfileEntity $storeOwnerProfile): void
    {
        $this->storeOwnerProfile = $storeOwnerProfile;
    }

    public function getImagesArray(): ?array
    {
        return $this->imagesArray;
    }
}
