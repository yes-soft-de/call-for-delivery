<?php

namespace App\Service\StoreOwnerBranch;

use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Entity\StoreOwnerBranchEntity;
use App\Manager\StoreOwnerBranch\StoreOwnerBranchManager;

class StoreBranchGetForGeoDistanceService
{
    public function __construct(
        private StoreOwnerBranchManager $storeOwnerBranchManager
    )
    {
    }

    /**
     * Get a specific store's branch by branch id
     */
    public function getStoreBranchById(int $id): string|StoreOwnerBranchEntity
    {
        $branchEntity = $this->storeOwnerBranchManager->getBranchById($id);

        if (! $branchEntity) {
            return StoreOwnerBranch::BRANCH_NOT_FOUND;
        }

        return $branchEntity;
    }

    /**
     * Get a specific store's branch location by branch id
     */
    public function getStoreBranchLocationById(int $id): array|string
    {
        $branchEntity = $this->getStoreBranchById($id);

        if ($branchEntity === StoreOwnerBranch::BRANCH_NOT_FOUND) {
            return StoreOwnerBranch::BRANCH_NOT_FOUND;
        }

        return $branchEntity->getLocation();
    }
}
