<?php

namespace App\Request\Supplier;

use App\Entity\SupplierCategoryEntity;
use App\Entity\UserEntity;

class SupplierProfileUpdateRequest
{
    private int|UserEntity $user;

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
     * @return UserEntity|int
     */
    public function getUser(): UserEntity|int
    {
        return $this->user;
    }

    /**
     * @param UserEntity|int $user
     */
    public function setUser(UserEntity|int $user): void
    {
        $this->user = $user;
    }

    public function getSupplierCategory(): int|SupplierCategoryEntity
    {
        return $this->supplierCategory;
    }

    public function setSupplierCategory(int|SupplierCategoryEntity $supplierCategory): void
    {
        $this->supplierCategory = $supplierCategory;
    }

    /**
     * @return array|null
     */
    public function getImages(): ?array
    {
        return $this->images;
    }
}
