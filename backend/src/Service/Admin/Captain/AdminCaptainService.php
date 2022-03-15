<?php

namespace App\Service\Admin\Captain;

use App\AutoMapping;
use App\Manager\Admin\Captain\AdminCaptainManager;
use App\Response\Admin\Captain\CaptainProfileGetForAdminResponse;

class AdminCaptainService
{
    private AutoMapping $autoMapping;
    private AdminCaptainManager $adminCaptainManager;

    public function __construct(AutoMapping $autoMapping, AdminCaptainManager $adminCaptainManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminCaptainManager = $adminCaptainManager;
    }

    public function getCaptainsProfilesByStatusForAdmin(string $captainProfileStatus): array
    {
        $response = [];

        $captainsProfiles = $this->adminCaptainManager->getCaptainsProfilesByStatusForAdmin($captainProfileStatus);

        foreach ($captainsProfiles as $captainProfile) {
            $response[] = $this->autoMapping->map('array', CaptainProfileGetForAdminResponse::class, $captainProfile);
        }

        return $response;
    }
}
