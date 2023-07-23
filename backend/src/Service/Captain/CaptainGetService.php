<?php

namespace App\Service\Captain;

use App\Constant\Captain\CaptainConstant;
use App\Entity\CaptainEntity;
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

    public function getCaptainProfileEntityById(int $captainProfileId): CaptainEntity|string
    {
        $captainProfile = $this->captainManager->getCaptainProfileById($captainProfileId);

        if (! $captainProfile) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
        }

        return $captainProfile;
    }

    public function getCaptainProfileByCaptainUserId(int $userId): CaptainEntity|string
    {
        $captainProfile = $this->captainManager->getCaptainProfileByUserId($userId);

        if (! $captainProfile) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
        }

        return $captainProfile;
    }
}
