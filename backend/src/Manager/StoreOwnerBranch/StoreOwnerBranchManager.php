<?php

namespace App\Manager\StoreOwnerBranch;

use App\AutoMapping;
use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Entity\StoreOwnerBranchEntity;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use App\Repository\StoreOwnerBranchEntityRepository;
use App\Request\StoreOwnerBranch\StoreOwnerBranchCreateRequest;
use App\Request\StoreOwnerBranch\StoreOwnerBranchUpdateRequest;
use App\Request\StoreOwnerBranch\StoreOwnerBranchDeleteRequest;
use Doctrine\ORM\EntityManagerInterface;

class StoreOwnerBranchManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private StoreOwnerBranchEntityRepository $storeOwnerBranchEntityRepository;
    private StoreOwnerProfileManager $storeOwnerProfileManager;

    /**
     * @param AutoMapping $autoMapping
     * @param EntityManagerInterface $entityManager
     * @param StoreOwnerBranchEntityRepository $storeOwnerBranchEntityRepository
     * @param StoreOwnerProfileManager $storeOwnerProfileManager
     */
    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, StoreOwnerBranchEntityRepository $storeOwnerBranchEntityRepository, StoreOwnerProfileManager $storeOwnerProfileManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->storeOwnerBranchEntityRepository = $storeOwnerBranchEntityRepository;
        $this->storeOwnerProfileManager = $storeOwnerProfileManager;
    }

    /**
     * @param StoreOwnerBranchCreateRequest $request
     * @return StoreOwnerBranchEntity|null
     */
    public function createBranch(StoreOwnerBranchCreateRequest $request):?StoreOwnerBranchEntity
    {
        $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId($request->getStoreOwner());
     
        $entity = $this->autoMapping->map(StoreOwnerBranchCreateRequest::class, StoreOwnerBranchEntity::class, $request);
        $entity->setIsActive(1);
        $entity->setStoreOwner($storeOwner);

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
        $entity->setIsActive(1);
        $entity->setStoreOwner($storeOwner);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();

        return $entity;
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

    /**
     * @param StoreOwnerBranchDeleteRequest $request
     * @return StoreOwnerBranchEntity|string
     */
    public function deletebranch(StoreOwnerBranchDeleteRequest $request): StoreOwnerBranchEntity|string
    {
        $entity = $this->storeOwnerBranchEntityRepository->find($request->getId());

        if ($entity) {
             
            $entity = $this->autoMapping->mapToObject(StoreOwnerBranchDeleteRequest::class, StoreOwnerBranchEntity::class, $request, $entity);

            $this->entityManager->flush();

            return $entity;
        }

        return StoreOwnerBranch::BRANCH_NOT_FOUND;
    }

    /**
     * @param $storeOwnerId
     * @return array
     */
    public function getAllBranches($storeOwnerId): array
    {
       $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId($storeOwnerId);
       
       return $this->storeOwnerBranchEntityRepository->findBy(['storeOwner' => $storeOwner->getId()]);
    }

    /**
     * @param $id
     * @return StoreOwnerBranchEntity|null
     */
    public function getBranchById($id): ?StoreOwnerBranchEntity
    {
       return $this->storeOwnerBranchEntityRepository->find($id);
    }
}
