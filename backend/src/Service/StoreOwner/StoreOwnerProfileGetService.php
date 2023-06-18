<?php

namespace App\Service\StoreOwner;

use App\Entity\StoreOwnerProfileEntity;
use App\Manager\StoreOwner\StoreOwnerProfileManager;

class StoreOwnerProfileGetService
{
    public function __construct(
        private StoreOwnerProfileManager $storeOwnerProfileManager
    )
    {
    }

    public function getStoreOwnerProfileByStoreId($storeOwnerId): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId(["storeOwnerId"=>$storeOwnerId]);
    }
}
