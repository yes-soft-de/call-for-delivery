<?php

namespace App\Service\StoreOwnerBranch;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Entity\StoreOwnerBranchEntity;
use App\Manager\StoreOwnerBranch\StoreOwnerBranchManager;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Request\StoreOwnerBranch\StoreOwnerBranchCreateRequest;
use App\Request\StoreOwnerBranch\StoreOwnerBranchDeleteRequest;
use App\Request\StoreOwnerBranch\StoreOwnerMultipleBranchesCreateRequest;
use App\Response\StoreOwnerBranch\StoreOwnerBranchResponse;

class StoreOwnerBranchService
{
    private $autoMapping;
    private $storeOwnerBranchManager;

    public function __construct(AutoMapping $autoMapping, StoreOwnerBranchManager $storeOwnerBranchManager)
    {
        $this->autoMapping = $autoMapping;
        $this->storeOwnerBranchManager = $storeOwnerBranchManager;
    }

    /**
     * @param StoreOwnerBranchCreateRequest $request
     * @return StoreOwnerBranchResponse|null
     */
    public function createBranch(StoreOwnerBranchCreateRequest $request): ?StoreOwnerBranchResponse
    {
        $branch = $this->storeOwnerBranchManager->createBranch($request);

        //--check and update completeAccountStatus for the store owner profile
        $this->checkCompleteAccountStatusOfStoreOwnerProfile($request->getStoreOwner());

        return $this->autoMapping->map(StoreOwnerBranchEntity::class, StoreOwnerBranchResponse::class, $branch);
    }

    /**
     * @param StoreOwnerMultipleBranchesCreateRequest $request
     * @return array|string
     */
    public function createMultipleBranches(StoreOwnerMultipleBranchesCreateRequest $request): array|string
    {
        $response = [];

        foreach($request->getBranches() as $branch) {

            $branchRequest = $this->autoMapping->map('array', StoreOwnerBranchCreateRequest::class, $branch);

            $branchRequest->setStoreOwner($request->getStoreOwner());

            $branchResult = $this->storeOwnerBranchManager->createBranchByStoreOwner($branchRequest);

            //--check and update completeAccountStatus for the store owner profile
            $this->checkCompleteAccountStatusOfStoreOwnerProfile($request->getStoreOwner());

            $response[] = $this->autoMapping->map(StoreOwnerBranchEntity::class, StoreOwnerBranchResponse::class, $branchResult);
        }

        return $response;
    }

    /**
     * @param $request
     * @return StoreOwnerBranchResponse|string
     */
    public function updateBranch($request): string|StoreOwnerBranchResponse
    {
        $result = $this->storeOwnerBranchManager->updateBranch($request);

        if($result === StoreOwnerBranch::BRANCH_NOT_FOUND) {
            return StoreOwnerBranch::BRANCH_NOT_FOUND;
        }

        return $this->autoMapping->map(StoreOwnerBranchEntity::class, StoreOwnerBranchResponse::class, $result);
    }

    /**
     * @param StoreOwnerBranchDeleteRequest $request
     * @return StoreOwnerBranchResponse|string
     */
    public function deleteBranch(StoreOwnerBranchDeleteRequest $request): string|StoreOwnerBranchResponse
    {
        $result = $this->storeOwnerBranchManager->deleteBranch($request);

        if($result === StoreOwnerBranch::BRANCH_NOT_FOUND) {
            return StoreOwnerBranch::BRANCH_NOT_FOUND;
        }

        return $this->autoMapping->map(StoreOwnerBranchEntity::class, StoreOwnerBranchResponse::class, $result);
    }

    /**
     * @param $storeOwnerId
     * @return array
     */
    public function getAllBranches($storeOwnerId): array
    {
        $response = [];

        $branches = $this->storeOwnerBranchManager->getAllBranches($storeOwnerId);

        foreach($branches as $branch) {

            $response[] =  $this->autoMapping->map('array', StoreOwnerBranchResponse::class, $branch);
        }
        
        return $response;
    }

    /**
     * @param $id
     * @return StoreOwnerBranchResponse|null
     */
    public function getBranchById($id): ?StoreOwnerBranchResponse
    {
        $branch = $this->storeOwnerBranchManager->getBranchById($id);

        return  $this->autoMapping->map(StoreOwnerBranchEntity::class, StoreOwnerBranchResponse::class, $branch);
    }

    /**
     * This function checks completeAccountStatus of the store owner profile and updates it when necessary
     * @param int $storeOwnerId
     */
    public function checkCompleteAccountStatusOfStoreOwnerProfile(int $storeOwnerId)
    {
        $storeOwnerProfileResult = $this->storeOwnerBranchManager->getStoreOwnerProfileByStoreOwnerId($storeOwnerId);

        if($storeOwnerProfileResult) {
            if($storeOwnerProfileResult->getCompleteAccountStatus() === StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_SUBSCRIPTION_CREATED) {
                // then we can update completeAccountStatus to subscriptionCreated

                $completeAccountStatusUpdateRequest = new CompleteAccountStatusUpdateRequest();

                $completeAccountStatusUpdateRequest->setUserId($storeOwnerId);
                $completeAccountStatusUpdateRequest->setCompleteAccountStatus(StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_BRANCH_CREATED);

                $this->storeOwnerBranchManager->storeOwnerProfileCompleteAccountStatusUpdate($completeAccountStatusUpdateRequest);
            }
        }
    }

    public function getBranchEntityById($id): ?StoreOwnerBranchEntity
    {
        return $this->storeOwnerBranchManager->getBranchById($id);
    }

    public function deleteAllStoreBranchesByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->storeOwnerBranchManager->deleteAllStoreBranchesByStoreOwnerId($storeOwnerId);
    }
}
