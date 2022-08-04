<?php

namespace App\Request\Admin\Package;

class PackageCategoryStatusUpdateByAdminRequest
{
    private int $id;

    private int $status;

    public function getId(): int
    {
        return $this->id;
    }

    public function getStatus(): int
    {
        return $this->status;
    }
}
