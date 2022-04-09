<?php

namespace App\Request\Admin\SupplierCategory;

class SupplierCategoryStatusUpdateByAdminRequest
{
    private int $id;

    private bool $status;

    /**
     * @return int
     */
    public function getId(): int
    {
        return $this->id;
    }
}
