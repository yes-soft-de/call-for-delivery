<?php

namespace App\Request\StoreOwnerBranch;

class StoreOwnerMultipleBranchesCreateByAdminRequest
{
    private int $storeOwnerProfileId;

    private array $branches;

    public function setStoreOwnerProfileId(int $storeOwnerProfileId): void
    {
        $this->storeOwnerProfileId = $storeOwnerProfileId;
    }

    public function getStoreOwnerProfileId(): int
    {
        return $this->storeOwnerProfileId;
    }

    public function getBranches(): ?array
    {
        return $this->branches;
    }
}
