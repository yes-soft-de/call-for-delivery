<?php

namespace App\Service\Admin\StoreOwner;

use App\Constant\StoreOwner\StoreProfileConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Manager\Admin\StoreOwner\AdminStoreOwnerManager;

class AdminStoreOwnerProfileGetService
{
    public function __construct(
        private AdminStoreOwnerManager $adminStoreOwnerManager
    )
    {}

    public function getStoreOwnerProfileEntityByIdForAdmin(int $id): string|StoreOwnerProfileEntity
    {
        $storeOwnerProfile = $this->adminStoreOwnerManager->getStoreOwnerProfileEntityByIdForAdmin($id);

        if (! $storeOwnerProfile) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        return $storeOwnerProfile;
    }
}
