<?php

namespace App\Manager\Admin\StoreOwner;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Repository\StoreOwnerProfileEntityRepository;
use App\Request\Admin\StoreOwner\StoreOwnerProfileStatusUpdateByAdminRequest;
use App\Request\Admin\StoreOwner\StoreOwnerProfileUpdateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminStoreOwnerManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private StoreOwnerProfileEntityRepository $storeOwnerProfileEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, StoreOwnerProfileEntityRepository $storeOwnerProfileEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->storeOwnerProfileEntityRepository = $storeOwnerProfileEntityRepository;
    }

    public function getStoreOwnerProfileByIdForAdmin(int $storeOwnerProfileId): ?array
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnerProfileByIdForAdmin($storeOwnerProfileId);
    }

    public function getStoreOwnerBranchesByStoreOwnerProfileIdForAdmin(int $storeOwnerProfileId): ?array
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnerBranchesByStoreOwnerProfileIdForAdmin($storeOwnerProfileId);
    }

    public function getStoreOwnersProfilesCountByStatusForAdmin(string $storeOwnerProfileStatus): int
    {
        return $this->storeOwnerProfileEntityRepository->count(["status" => $storeOwnerProfileStatus]);
    }

    public function getStoreOwnersProfilesByStatusForAdmin(string $storeOwnerProfileStatus): ?array
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnersProfilesByStatusForAdmin($storeOwnerProfileStatus);
    }

    public function updateStoreOwnerProfileStatusByAdmin(StoreOwnerProfileStatusUpdateByAdminRequest $request): string|StoreOwnerProfileEntity
    {
        $storeOwnerProfileEntity = $this->storeOwnerProfileEntityRepository->find($request->getId());

        if(! $storeOwnerProfileEntity) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        $storeOwnerProfileEntity = $this->autoMapping->mapToObject(StoreOwnerProfileStatusUpdateByAdminRequest::class, StoreOwnerProfileEntity::class,
            $request, $storeOwnerProfileEntity);

        $this->entityManager->flush();

        return $storeOwnerProfileEntity;
    }

    public function updateStoreOwnerProfileByAdmin(StoreOwnerProfileUpdateByAdminRequest $request): string|StoreOwnerProfileEntity
    {
        $storeOwnerProfileEntity = $this->storeOwnerProfileEntityRepository->find($request->getId());

        if (! $storeOwnerProfileEntity) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        $storeOwnerProfileEntity = $this->autoMapping->mapToObject(StoreOwnerProfileUpdateByAdminRequest::class, StoreOwnerProfileEntity::class,
            $request, $storeOwnerProfileEntity);

        $storeOwnerProfileEntity->setOpeningTime($request->getOpeningTime());
        $storeOwnerProfileEntity->setClosingTime($request->getClosingTime());

        $this->entityManager->flush();

        return $storeOwnerProfileEntity;
    }

    public function getLastThreeActiveStoreOwnersProfilesForAdmin(): array
    {
        return $this->storeOwnerProfileEntityRepository->getLastThreeActiveStoreOwnersProfilesForAdmin();
    }

    public function getStoreOwnerProfileEntityByStoreOwnerId(int $storeOwnerId): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileEntityRepository->findOneBy(['storeOwnerId'=>$storeOwnerId]);
    }
}
