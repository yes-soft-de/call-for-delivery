<?php

namespace App\Request\Admin\SupplierProfile;

class SupplierProfileStatusUpdateByAdminRequest
{
    private int $id;

    private bool $status;

    public function getId(): int
    {
        return $this->id;
    }
}
