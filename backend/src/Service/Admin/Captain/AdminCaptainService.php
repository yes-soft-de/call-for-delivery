<?php

namespace App\Service\Admin\Captain;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Entity\CaptainEntity;
use App\Manager\Admin\Captain\AdminCaptainManager;
use App\Request\Admin\Captain\CaptainProfileStatusUpdateByAdminRequest;
use App\Request\Admin\Captain\CaptainProfileUpdateByAdminRequest;
use App\Response\Admin\Captain\CaptainProfileGetForAdminResponse;
use App\Service\FileUpload\UploadFileHelperService;

class AdminCaptainService
{
    private AutoMapping $autoMapping;
    private AdminCaptainManager $adminCaptainManager;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, AdminCaptainManager $adminCaptainManager, UploadFileHelperService $uploadFileHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminCaptainManager = $adminCaptainManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
    }

    public function getCaptainsProfilesByStatusForAdmin(string $captainProfileStatus): array
    {
        $response = [];

        $captainsProfiles = $this->adminCaptainManager->getCaptainsProfilesByStatusForAdmin($captainProfileStatus);

        foreach ($captainsProfiles as $captainProfile) {
            $captainProfile['images'] = $this->uploadFileHelperService->getImageParams($captainProfile['images']);

            $response[] = $this->autoMapping->map('array', CaptainProfileGetForAdminResponse::class, $captainProfile);
        }

        return $response;
    }

    public function getCaptainProfileByIdForAdmin(int $captainProfileId): ?CaptainProfileGetForAdminResponse
    {
        $captainProfile = $this->adminCaptainManager->getCaptainProfileByIdForAdmin($captainProfileId);

        if ($captainProfile) {
            $captainProfile['images'] = $this->uploadFileHelperService->getImageParams($captainProfile['images']);

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

    public function updateCaptainProfileByAdmin(CaptainProfileUpdateByAdminRequest $request): string|CaptainProfileGetForAdminResponse
    {
        $captainProfile = $this->adminCaptainManager->updateCaptainProfileByAdmin($request);

        if ($captainProfile === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;

        } else {
            return $this->autoMapping->map(CaptainEntity::class, CaptainProfileGetForAdminResponse::class, $captainProfile);
        }
    }
}
