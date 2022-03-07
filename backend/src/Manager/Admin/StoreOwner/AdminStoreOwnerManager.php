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

    public function getStoreOwnersProfilesCountByStatusForAdmin(string $storeOwnerProfileStatus): string
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnersProfilesCountByStatusForAdmin($storeOwnerProfileStatus);
    }
}
