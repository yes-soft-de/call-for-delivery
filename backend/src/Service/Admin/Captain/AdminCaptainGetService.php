<?php

namespace App\Service\Admin\Captain;

use App\Manager\Admin\Captain\AdminCaptainManager;

class AdminCaptainGetService
{
    public function __construct(
        private AdminCaptainManager $adminCaptainManager
    )
    {
    }

    /**
     * Get active and online captains' profiles with profile images
     */
    public function getActiveAndOnlineCaptainsForAdmin(): array
    {
        return $this->adminCaptainManager->getActiveAndOnlineCaptainsForAdmin();
    }
}
