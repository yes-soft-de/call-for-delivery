<?php

namespace App\Request\Package;

class PackageStatusUpdateRequest
{
    private $id;

    private $status;

    /**
     * @return int|null
     */
    public function getId(): ?int
    {
        return $this->id;
    }
}
