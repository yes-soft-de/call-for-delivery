<?php

namespace App\Service\Admin\StoreOwnerBranch;

use App\AutoMapping;
use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Entity\StoreOwnerBranchEntity;
use App\Manager\Admin\StoreOwnerBranch\AdminStoreOwnerBranchManager;
use App\Request\Admin\StoreOwnerBranch\StoreOwnerBranchUpdateByAdminRequest;
use App\Request\StoreOwnerBranch\StoreOwnerBranchCreateRequest;
use App\Request\Admin\StoreOwnerBranch\StoreOwnerMultipleBranchesCreateByAdminRequest;
use App\Request\StoreOwnerBranch\StoreOwnerBranchDeleteRequest;
use App\Response\Admin\StoreOwnerBranch\StoreOwnerBranchGetForAdminResponse;

class AdminStoreOwnerBranchService
{
    private AutoMapping $autoMapping;
    private AdminStoreOwnerBranchManager $adminStoreOwnerBranchManager;

    public function __construct(AutoMapping $autoMapping, AdminStoreOwnerBranchManager $adminStoreOwnerBranchManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminStoreOwnerBranchManager = $adminStoreOwnerBranchManager;
    }

    public function createMultipleBranchesByAdmin(StoreOwnerMultipleBranchesCreateByAdminRequest $request): array|string
    {
        $response = [];

        foreach($request->getBranches() as $branch) {
            $branchRequest = $this->autoMapping->map('array', StoreOwnerBranchCreateRequest::class, $branch);

            $branchRequest->setStoreOwner($request->getStoreOwnerProfileId());

            $branchResult = $this->adminStoreOwnerBranchManager->createBranchesByAdmin($branchRequest);

            $response[] = $this->autoMapping->map(StoreOwnerBranchEntity::class, StoreOwnerBranchGetForAdminResponse::class, $branchResult);
        }

        return $response;
    }

    public function updateBranchByAdmin(StoreOwnerBranchUpdateByAdminRequest $request): string|StoreOwnerBranchGetForAdminResponse
    {
        $result = $this->adminStoreOwnerBranchManager->updateBranchByAdmin($request);

        if($result === StoreOwnerBranch::BRANCH_NOT_FOUND) {
            return StoreOwnerBranch::BRANCH_NOT_FOUND;
        }

        return $this->autoMapping->map(StoreOwnerBranchEntity::class, StoreOwnerBranchGetForAdminResponse::class, $result);
    }

    public function getActiveBranchesByStoreOwnerIdForAdmin(int $storeOwnerId): array
    {
        $response = [];

        $branches = $this->adminStoreOwnerBranchManager->getActiveBranchesByStoreOwnerIdForAdmin($storeOwnerId);

        foreach($branches as $branch) {
            $response[] = $this->autoMapping->map('array', StoreOwnerBranchGetForAdminResponse::class, $branch);
        }

        return $response;
    }

    public function deleteBranchByAdmin(StoreOwnerBranchDeleteRequest $request): string|StoreOwnerBranchGetForAdminResponse
    {
        $result = $this->adminStoreOwnerBranchManager->deleteBranchByAdmin($request);

        if($result === StoreOwnerBranch::BRANCH_NOT_FOUND) {
            return StoreOwnerBranch::BRANCH_NOT_FOUND;
        }

        return $this->autoMapping->map(StoreOwnerBranchEntity::class, StoreOwnerBranchGetForAdminResponse::class, $result);
    }
}
