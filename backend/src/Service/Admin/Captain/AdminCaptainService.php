<?php

namespace App\Service\Admin\Captain;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Entity\CaptainEntity;
use App\Manager\Admin\Captain\AdminCaptainManager;
use App\Request\Admin\Captain\CaptainProfileStatusUpdateByAdminRequest;
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

    public function getCaptainProfileByIdForAdmin(int $captainProfileId): ?CaptainProfileGetForAdminResponse
    {
        $captainProfile = $this->adminCaptainManager->getCaptainProfileByIdForAdmin($captainProfileId);

        if ($captainProfile) {
            if($captainProfile['roomId']) {
                $captainProfile['roomId'] = $captainProfile['roomId']->toBase32();
            }
        }

        return $this->autoMapping->map('array', CaptainProfileGetForAdminResponse::class, $captainProfile);
    }

    public function updateCaptainProfileStatusByAdmin(CaptainProfileStatusUpdateByAdminRequest $request): string|CaptainProfileGetForAdminResponse
    {
        $captainProfile = $this->adminCaptainManager->updateCaptainProfileStatusByAdmin($request);

        if ($captainProfile === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;

        } else {
            return $this->autoMapping->map(CaptainEntity::class, CaptainProfileGetForAdminResponse::class, $captainProfile);
        }
    }
}
