<?php

namespace App\Service\Admin\StoreOwnerBranch;

use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Entity\StoreOwnerBranchEntity;
use App\Manager\Admin\StoreOwnerBranch\AdminStoreOwnerBranchManager;

class AdminStoreOwnerBranchGetService
{
    public function __construct(
        private AdminStoreOwnerBranchManager $adminStoreOwnerBranchManager
    )
    {
    }

    /**
     * Get array of branch id, branch name, store id. store name, and store profile image for admin
     */
    public function getBranchesForAdmin(): array
    {
        return $this->adminStoreOwnerBranchManager->getBranchesForAdmin();
    }

    public function getStoreBranchEntityById(int $branchId): StoreOwnerBranchEntity|string
    {
        $branchEntity = $this->adminStoreOwnerBranchManager->getBranchById($branchId);

        if (! $branchEntity) {
            return StoreOwnerBranch::BRANCH_NOT_FOUND;
        }

        return $branchEntity;
    }
}
