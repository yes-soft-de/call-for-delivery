<?php

namespace App\Request\Supplier;

use App\Entity\UserEntity;

class SupplierProfileCreateRequest
{
    private UserEntity $user;

    private string $supplierName;

    /**
     * @var string|null
     */
    private $phone;

    /**
     * @param UserEntity $user
     */
    public function setUser(UserEntity $user): void
    {
        $this->user = $user;
    }

    /**
     * @param string $supplierName
     */
    public function setSupplierName(string $supplierName): void
    {
        $this->supplierName = $supplierName;
    }
}
