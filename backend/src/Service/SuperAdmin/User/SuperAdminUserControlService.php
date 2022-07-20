<?php

namespace App\Service\SuperAdmin\User;

use App\Manager\SuperAdmin\User\SuperAdminUserControlManager;

class SuperAdminUserControlService
{
    private SuperAdminUserControlManager $superAdminUserControlManager;

    public function __construct(SuperAdminUserControlManager $superAdminStoreOwnerProfileManager)
    {
        $this->superAdminUserControlManager = $superAdminStoreOwnerProfileManager;
    }

    // This function updates createdAt field for all store owners, and captains profiles and their related users
    public function updateCreatedAtForAllStoreOwnersAndCaptainsBySuperAdmin(): array
    {
        $response = [];

        $storeOwnersProfiles = $this->superAdminUserControlManager->updateCreatedAtForAllStoreOwnersProfilesBySuperAdmin();
        $captainsProfiles = $this->superAdminUserControlManager->updateCreatedAtForAllCaptainsProfilesBySuperAdmin();

        if (! empty($storeOwnersProfiles)) {
            foreach ($storeOwnersProfiles as $storeOwnerProfile) {
                $response['storeOwners'][] = $storeOwnerProfile->getStoreOwnerName();
            }
        }

        if (! empty($captainsProfiles)) {
            foreach ($captainsProfiles as $captainProfile) {
                $response['captains'][] = $captainProfile->getCaptainName();
            }
        }

        return $response;
    }
}
