<?php

namespace App\Service\Admin\AdminProfile;

use App\Constant\Admin\AdminProfileConstant;
use App\Entity\AdminProfileEntity;
use App\Manager\Admin\AdminProfile\AdminProfileManager;

/**
 * This service had been created just for fetch information related to admin profile by other services
 */
class AdminProfileGetService
{
    public function __construct(
        private AdminProfileManager $adminProfileManager
    )
    {
    }

    /**
     * Get admin profile entity if exists
     */
    public function getAdminProfileEntityByAdminUserId(int $adminUserId): AdminProfileEntity|string
    {
        $adminProfileEntity = $this->adminProfileManager->getAdminProfileByAdminUserId($adminUserId);

        if (! $adminProfileEntity) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;
        }

        return $adminProfileEntity;
    }
}
