<?php

namespace App\Manager\Admin\Captain;

use App\Entity\CaptainEntity;
use App\Manager\Captain\CaptainManager;
use App\Request\Admin\Captain\CaptainProfileStatusUpdateByAdminRequest;

class AdminCaptainManager
{
    private CaptainManager $captainManager;

    public function __construct(CaptainManager $captainManager)
    {
        $this->captainManager = $captainManager;
    }

    public function getCaptainsProfilesByStatusForAdmin(string $captainProfileStatus): ?array
    {
        return $this->captainManager->getCaptainsProfilesByStatusForAdmin($captainProfileStatus);
    }

    public function getCaptainProfileByIdForAdmin(int $captainProfileId): ?array
    {
        return $this->captainManager->getCaptainProfileByIdForAdmin($captainProfileId);
    }

    public function updateCaptainProfileStatusByAdmin(CaptainProfileStatusUpdateByAdminRequest $request): string|CaptainEntity
    {
        return $this->captainManager->updateCaptainProfileStatusByAdmin($request);
    }
}
