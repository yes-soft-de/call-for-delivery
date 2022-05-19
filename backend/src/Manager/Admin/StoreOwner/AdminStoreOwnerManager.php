<?php

namespace App\Manager\Admin\StoreOwner;

use App\Repository\StoreOwnerProfileEntityRepository;

class AdminStoreOwnerManager
{
    private StoreOwnerProfileEntityRepository $storeOwnerProfileEntityRepository;

    public function __construct(StoreOwnerProfileEntityRepository $storeOwnerProfileEntityRepository)
    {
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
}
