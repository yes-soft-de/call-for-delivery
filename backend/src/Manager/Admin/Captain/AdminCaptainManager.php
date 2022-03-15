<?php

namespace App\Manager\Admin\Captain;

use App\Manager\Captain\CaptainManager;

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
}
