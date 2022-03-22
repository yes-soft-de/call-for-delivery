<?php

namespace App\Service\Admin\Captain;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Entity\CaptainEntity;
use App\Manager\Admin\Captain\AdminCaptainManager;
use App\Request\Admin\Captain\CaptainProfileStatusUpdateByAdminRequest;
use App\Request\Admin\Captain\CaptainProfileUpdateByAdminRequest;
use App\Response\Admin\Captain\CaptainProfileGetForAdminResponse;
use App\Service\FileUpload\UploadFileHelperService;
use App\Service\Image\ImageService;

class AdminCaptainService
{
    private AutoMapping $autoMapping;
    private AdminCaptainManager $adminCaptainManager;
    private UploadFileHelperService $uploadFileHelperService;
    private ImageService $imageService;

    public function __construct(AutoMapping $autoMapping, AdminCaptainManager $adminCaptainManager, UploadFileHelperService $uploadFileHelperService, ImageService $imageService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminCaptainManager = $adminCaptainManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
        $this->imageService = $imageService;
    }

    public function getCaptainsProfilesByStatusForAdmin(string $captainProfileStatus): array
    {
        $response = [];

        $captainsProfiles = $this->adminCaptainManager->getCaptainsProfilesByStatusForAdmin($captainProfileStatus);

        foreach ($captainsProfiles as $captainProfile) {
            $captainProfile['images'] = $this->imageService->getOneImageByItemIdAndEntityTypeAndImageAim($captainProfile['id'], ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE);

            $captainProfile['drivingLicence'] = $this->imageService->getOneImageByItemIdAndEntityTypeAndImageAim($captainProfile['id'], ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_DRIVE_LICENSE_IMAGE);

            $captainProfile['mechanicLicense'] = $this->imageService->getOneImageByItemIdAndEntityTypeAndImageAim($captainProfile['id'], ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_MECHANIC_LICENSE_IMAGE);

            $captainProfile['identity'] = $this->imageService->getOneImageByItemIdAndEntityTypeAndImageAim($captainProfile['id'], ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_IDENTITY_IMAGE);

            if (empty($captainProfile['location'])) {
                $captainProfile['location'] = null;
            }

            $response[] = $this->autoMapping->map('array', CaptainProfileGetForAdminResponse::class, $captainProfile);
        }

        return $response;
    }

    public function getCaptainProfileByIdForAdmin(int $captainProfileId): ?CaptainProfileGetForAdminResponse
    {
        $captainProfile = $this->adminCaptainManager->getCaptainProfileByIdForAdmin($captainProfileId);

        if ($captainProfile) {
            $captainProfile['images'] = $this->imageService->getOneImageByItemIdAndEntityTypeAndImageAim($captainProfileId, ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE);

            $captainProfile['drivingLicence'] = $this->imageService->getOneImageByItemIdAndEntityTypeAndImageAim($captainProfileId, ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_DRIVE_LICENSE_IMAGE);

            $captainProfile['mechanicLicense'] = $this->imageService->getOneImageByItemIdAndEntityTypeAndImageAim($captainProfileId, ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_MECHANIC_LICENSE_IMAGE);

            $captainProfile['identity'] = $this->imageService->getOneImageByItemIdAndEntityTypeAndImageAim($captainProfileId, ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_IDENTITY_IMAGE);

            if($captainProfile['roomId']) {
                $captainProfile['roomId'] = $captainProfile['roomId']->toBase32();
            }

            if (empty($captainProfile['location'])) {
                $captainProfile['location'] = null;
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
