<?php

namespace App\Service\Admin\StoreOwner;

use App\Manager\Admin\StoreOwner\AdminStoreOwnerManager;

class AdminStoreOwnerService
{
    private AdminStoreOwnerManager $adminStoreOwnerManager;

    public function __construct(AdminStoreOwnerManager $adminStoreOwnerManager)
    {
        $this->adminStoreOwnerManager = $adminStoreOwnerManager;
    }

    public function getStoreOwnersProfilesCountByStatusForAdmin(string $storeOwnerProfileStatus): string
    {
        return $this->adminStoreOwnerManager->getStoreOwnersProfilesCountByStatusForAdmin($storeOwnerProfileStatus);
    }
}
