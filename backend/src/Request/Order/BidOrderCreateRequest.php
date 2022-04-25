<?php

namespace App\Request\Order;

use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SupplierCategoryEntity;

class BidOrderCreateRequest
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
     * @var float|null
     */
    private $orderCost;

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

//    /**
//     * @var int|StoreOwnerProfileEntity
//     */
//    private $storeOwnerProfile;

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

//    public function getStoreOwnerProfile(): int|StoreOwnerProfileEntity
//    {
//        return $this->storeOwnerProfile;
//    }
//
//    public function setStoreOwnerProfile(int|StoreOwnerProfileEntity $storeOwnerProfile): void
//    {
//        $this->storeOwnerProfile = $storeOwnerProfile;
//    }

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
