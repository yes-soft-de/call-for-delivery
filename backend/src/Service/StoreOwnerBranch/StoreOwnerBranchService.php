<?php

namespace App\Service\StoreOwnerBranch;

use App\AutoMapping;
use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Entity\StoreOwnerBranchEntity;
use App\Manager\StoreOwnerBranch\StoreOwnerBranchManager;
use App\Request\StoreOwnerBranch\StoreOwnerBranchCreateRequest;
use App\Request\StoreOwnerBranch\StoreOwnerBranchDeleteRequest;
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

        return $this->autoMapping->map(StoreOwnerBranchEntity::class, StoreOwnerBranchResponse::class, $branch);
    }

    /**
     * @param $request
     * @return StoreOwnerBranchResponse|string
     */
    public function updateBranch($request): string|StoreOwnerBranchResponse
    {
        $result = $this->storeOwnerBranchManager->updateBranch($request);
        if($result === StoreOwnerBranch::BRANCH_NOT_FOUND){

            return StoreOwnerBranch::BRANCH_NOT_FOUND;
        }

        return $this->autoMapping->map(StoreOwnerBranchEntity::class, StoreOwnerBranchResponse::class, $result);
    }

    /**
     * @param StoreOwnerBranchDeleteRequest $request
     * @return StoreOwnerBranchResponse|string
     */
    public function deletebranch(StoreOwnerBranchDeleteRequest $request): string|StoreOwnerBranchResponse
    {
        $result = $this->storeOwnerBranchManager->deletebranch($request);
        if($result === StoreOwnerBranch::BRANCH_NOT_FOUND){

            return StoreOwnerBranch::BRANCH_NOT_FOUND;
        }

        return $this->autoMapping->map(StoreOwnerBranchEntity::class, StoreOwnerBranchResponse::class, $result);
    }

    /**
     * @param $storeOwnerId
     * @return array
     */
    public function getAllBranches($storeOwnerId):array
    {
        $response = [];

        $branches = $this->storeOwnerBranchManager->getAllBranches($storeOwnerId);

        foreach($branches as $branch) {

            $response[] =  $this->autoMapping->map(StoreOwnerBranchEntity::class, StoreOwnerBranchResponse::class, $branch);
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
}
