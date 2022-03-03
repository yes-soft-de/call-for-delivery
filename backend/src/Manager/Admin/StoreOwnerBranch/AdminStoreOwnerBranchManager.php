<?php

namespace App\Manager\Admin\StoreOwnerBranch;

use App\Entity\StoreOwnerBranchEntity;
use App\Manager\StoreOwnerBranch\StoreOwnerBranchManager;
use App\Request\StoreOwnerBranch\StoreOwnerBranchCreateRequest;
use App\Request\Admin\StoreOwnerBranch\StoreOwnerBranchUpdateByAdminRequest;
use App\Request\StoreOwnerBranch\StoreOwnerBranchDeleteRequest;

class AdminStoreOwnerBranchManager
{
    private StoreOwnerBranchManager $storeOwnerBranchManager;

    public function __construct(StoreOwnerBranchManager $storeOwnerBranchManager)
    {
        $this->storeOwnerBranchManager = $storeOwnerBranchManager;
    }

    public function createBranchesByAdmin(StoreOwnerBranchCreateRequest $request): ?StoreOwnerBranchEntity
    {
        return $this->storeOwnerBranchManager->createBranchesByAdmin($request);
    }

    public function updateBranchByAdmin(StoreOwnerBranchUpdateByAdminRequest $request): StoreOwnerBranchEntity|string
    {
        return $this->storeOwnerBranchManager->updateBranchByAdmin($request);
    }

    public function getActiveBranchesByStoreOwnerIdForAdmin(int $storeOwnerId): ?array
    {
        return $this->storeOwnerBranchManager->getActiveBranchesByStoreOwnerIdForAdmin($storeOwnerId);
    }

    public function deleteBranchByAdmin(StoreOwnerBranchDeleteRequest $request): StoreOwnerBranchEntity|string
    {
        return $this->storeOwnerBranchManager->deleteBranch($request);
    }
}
