<?php

namespace App\Manager\Admin\StoreOwnerBranch;

use App\Entity\StoreOwnerBranchEntity;
use App\Manager\StoreOwnerBranch\StoreOwnerBranchManager;
use App\Request\StoreOwnerBranch\StoreOwnerBranchCreateRequest;
use App\Request\Admin\StoreOwnerBranch\StoreOwnerBranchUpdateByAdminRequest;
use App\Request\StoreOwnerBranch\StoreOwnerBranchDeleteRequest;
use App\Repository\StoreOwnerBranchEntityRepository;

class AdminStoreOwnerBranchManager
{
    public function __construct(
        private StoreOwnerBranchManager $storeOwnerBranchManager,
        private StoreOwnerBranchEntityRepository $storeOwnerBranchEntityRepository
    )
    {
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

    public function getBranchById($id): ?StoreOwnerBranchEntity
    {
       return $this->storeOwnerBranchEntityRepository->find($id);
    }

    /**
     * Get array of branch id, branch name, store id. store name, and store profile image for admin
     */
    public function getBranchesForAdmin(): array
    {
        return $this->storeOwnerBranchEntityRepository->getBranchesForAdmin();
    }
}
