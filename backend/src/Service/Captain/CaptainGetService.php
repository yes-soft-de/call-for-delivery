<?php

namespace App\Service\Captain;

use App\Constant\Captain\CaptainConstant;
use App\Manager\Captain\CaptainManager;

/**
 * This service responsible just for fetching captain profile info functions
 */
class CaptainGetService
{
    public function __construct(
        private CaptainManager $captainManager
    )
    {
    }

    public function getCaptainProfileIdByCaptainUserId(int $userId): int|string
    {
        $captainProfile = $this->captainManager->getCaptainProfileByUserId($userId);

        if (! $captainProfile) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
        }

        return $captainProfile->getId();
    }
}
