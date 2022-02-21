<?php

namespace App\Request\StoreOwnerBranch;

class StoreOwnerMultipleBranchesCreateRequest
{
    private string $storeOwner;

    private array $branches;

    /**
     * @param string $storeOwner
     */
    public function setStoreOwner(string $storeOwner): void
    {
        $this->storeOwner = $storeOwner;
    }

    /**
     * @return string
     */
    public function getStoreOwner(): string
    {
        return $this->storeOwner;
    }

    /**
     * @return array|null
     */
    public function getBranches(): ?array
    {
        return $this->branches;
    }
}
