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
}
