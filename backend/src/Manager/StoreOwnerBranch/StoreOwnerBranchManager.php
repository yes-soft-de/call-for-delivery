<?php

namespace App\Manager\StoreOwnerBranch;

use App\AutoMapping;
use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use App\Repository\StoreOwnerBranchEntityRepository;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Request\Admin\StoreOwnerBranch\StoreOwnerBranchUpdateByAdminRequest;
use App\Request\StoreOwnerBranch\StoreOwnerBranchCreateRequest;
use App\Request\StoreOwnerBranch\StoreOwnerBranchUpdateRequest;
use App\Request\StoreOwnerBranch\StoreOwnerBranchDeleteRequest;
use Doctrine\ORM\EntityManagerInterface;

class StoreOwnerBranchManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private StoreOwnerBranchEntityRepository $storeOwnerBranchEntityRepository,
        private StoreOwnerProfileManager $storeOwnerProfileManager
    )
    {
    }

    /**
     * @param StoreOwnerBranchCreateRequest $request
     * @return StoreOwnerBranchEntity|null
     */
    public function createBranch(StoreOwnerBranchCreateRequest $request):?StoreOwnerBranchEntity
    {
        $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId($request->getStoreOwner());
     
        $entity = $this->autoMapping->map(StoreOwnerBranchCreateRequest::class, StoreOwnerBranchEntity::class, $request);
        $entity->setIsActive(StoreOwnerBranch::BRANCH_IS_ACTIVE);
        $entity->setStoreOwner($storeOwner);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        
        return $entity;
    }

    public function createDefaultBranch(StoreOwnerBranchCreateRequest $request): StoreOwnerBranchEntity
    {
        $entity = $this->autoMapping->map(StoreOwnerBranchCreateRequest::class, StoreOwnerBranchEntity::class, $request);

        $entity->setIsActive(StoreOwnerBranch::BRANCH_IS_ACTIVE);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();

        return $entity;
    }

    /**
     * @param StoreOwnerBranchCreateRequest $request
     * @return StoreOwnerBranchEntity|null
     */
    public function createBranchByStoreOwner(StoreOwnerBranchCreateRequest $request):?StoreOwnerBranchEntity
    {
        $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreOwnerId($request->getStoreOwner());

        $entity = $this->autoMapping->map(StoreOwnerBranchCreateRequest::class, StoreOwnerBranchEntity::class, $request);
        $entity->setIsActive(StoreOwnerBranch::BRANCH_IS_ACTIVE);
        $entity->setStoreOwner($storeOwner);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();

        return $entity;
    }

    public function createBranchesByAdmin(StoreOwnerBranchCreateRequest $request): ?StoreOwnerBranchEntity
    {
        $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfile($request->getStoreOwner());

        $branchEntity = $this->autoMapping->map(StoreOwnerBranchCreateRequest::class, StoreOwnerBranchEntity::class, $request);
        $branchEntity->setIsActive(StoreOwnerBranch::BRANCH_IS_ACTIVE);
        $branchEntity->setStoreOwner($storeOwner);

        $this->entityManager->persist($branchEntity);
        $this->entityManager->flush();

        return $branchEntity;
    }

    /**
     * @param StoreOwnerBranchUpdateRequest $request
     * @return StoreOwnerBranchEntity|string
     */
    public function updateBranch(StoreOwnerBranchUpdateRequest $request): StoreOwnerBranchEntity|string
    {
        $entity = $this->storeOwnerBranchEntityRepository->find($request->getId());

        if ($entity) {
             
            $entity = $this->autoMapping->mapToObject(StoreOwnerBranchUpdateRequest::class, StoreOwnerBranchEntity::class, $request, $entity);

            $this->entityManager->flush();

            return $entity;
        }

        return StoreOwnerBranch::BRANCH_NOT_FOUND;
    }

    public function updateBranchByAdmin(StoreOwnerBranchUpdateByAdminRequest $request): StoreOwnerBranchEntity|string
    {
        $branchEntity = $this->storeOwnerBranchEntityRepository->find($request->getId());

        if (! $branchEntity) {
            return StoreOwnerBranch::BRANCH_NOT_FOUND;

        } else {
            $branchEntity = $this->autoMapping->mapToObject(StoreOwnerBranchUpdateByAdminRequest::class, StoreOwnerBranchEntity::class, $request, $branchEntity);

            $this->entityManager->flush();

            return $branchEntity;
        }
    }

    public function deleteBranch(StoreOwnerBranchDeleteRequest $request): StoreOwnerBranchEntity|string
    {
        $branchEntity = $this->storeOwnerBranchEntityRepository->find($request->getId());

        if (! $branchEntity) {
            return StoreOwnerBranch::BRANCH_NOT_FOUND;

        } else {
            $branchEntity = $this->autoMapping->mapToObject(StoreOwnerBranchDeleteRequest::class, StoreOwnerBranchEntity::class, $request, $branchEntity);

            $this->entityManager->flush();

            return $branchEntity;
        }
    }

    /**
     * @param $storeOwnerId
     * @return array
     */
    public function getAllBranches($storeOwnerId): array
    {
       $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId($storeOwnerId);

       return $this->storeOwnerBranchEntityRepository->getActiveBranchesByStoreOwnerId($storeOwner->getId());
    }

    /**
     * @param $id
     * @return StoreOwnerBranchEntity|null
     */
    public function getBranchById($id): ?StoreOwnerBranchEntity
    {
       return $this->storeOwnerBranchEntityRepository->find($id);
    }

    public function getActiveBranchesByStoreOwnerIdForAdmin(int $storeOwnerId): ?array
    {
        return $this->storeOwnerBranchEntityRepository->getActiveBranchesByStoreOwnerId($storeOwnerId);
    }

    public function getStoreOwnerProfileByStoreOwnerId(int $storeOwnerId): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreOwnerId($storeOwnerId);
    }

    public function storeOwnerProfileCompleteAccountStatusUpdate(CompleteAccountStatusUpdateRequest $request): StoreOwnerProfileEntity|string
    {
        return $this->storeOwnerProfileManager->storeOwnerProfileCompleteAccountStatusUpdate($request);
    }

    public function deleteAllStoreBranchesByStoreOwnerId(int $storeOwnerId): array
    {
        $branches = $this->storeOwnerBranchEntityRepository->getAllStoreBranchesByStoreOwnerId($storeOwnerId);

        if (! empty($branches)) {
            foreach ($branches as $branch) {
                $this->entityManager->remove($branch);
                $this->entityManager->flush();
            }
        }

        return $branches;
    }
}
