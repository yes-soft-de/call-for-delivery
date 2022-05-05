<?php

namespace App\Request\Order;

use App\Entity\StoreOwnerBranchEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SupplierCategoryEntity;

class BidDetailsCreateRequest
{
    /**
     * @var string|null
     */
    private $payment;

    /**
     * @var string|null
     */
    private $note;

    /**
     * @var int|StoreOwnerProfileEntity
     */
    private $storeOwner;

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
     * @var int|StoreOwnerBranchEntity
     */
    private $branch;

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

    public function getBranch(): int|StoreOwnerBranchEntity
    {
        return $this->branch;
    }

    public function setBranch(int|StoreOwnerBranchEntity $branch)
    {
        $this->branch = $branch;
    }

    public function getImagesArray(): ?array
    {
        return $this->imagesArray;
    }

    public function getStoreOwner(): int|StoreOwnerProfileEntity
    {
        return $this->storeOwner;
    }

    public function setStoreOwner(int|StoreOwnerProfileEntity $storeOwner): void
    {
        $this->storeOwner = $storeOwner;
    }
}
