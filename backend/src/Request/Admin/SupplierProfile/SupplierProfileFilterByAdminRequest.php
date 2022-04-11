<?php

namespace App\Request\Admin\SupplierProfile;

class SupplierProfileFilterByAdminRequest
{
    /**
     * @var string|null
     */
    private $supplierName;

    /**
     * @var string|null
     */
    private $phone;

    /**
     * @var bool|null
     */
    private $status;

    /**
     * @var int|null
     */
    private $supplierCategoryId;

    public function getSupplierName(): ?string
    {
        return $this->supplierName;
    }

    public function getPhone(): ?string
    {
        return $this->phone;
    }

    public function getStatus(): ?bool
    {
        return $this->status;
    }

    public function getSupplierCategoryId(): ?int
    {
        return $this->supplierCategoryId;
    }
}
