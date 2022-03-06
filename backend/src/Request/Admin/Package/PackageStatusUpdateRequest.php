<?php

namespace App\Request\Admin\Package;

class PackageStatusUpdateRequest
{
    private int $id;

    private string $status;

    public function getId(): int
    {
        return $this->id;
    }
}
