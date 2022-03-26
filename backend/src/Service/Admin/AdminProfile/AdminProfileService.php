<?php

namespace App\Service\Admin\AdminProfile;

use App\AutoMapping;
use App\Constant\Admin\AdminProfileConstant;
use App\Entity\AdminProfileEntity;
use App\Manager\Admin\AdminProfile\AdminProfileManager;
use App\Request\Admin\AdminProfile\AdminProfileRequest;
use App\Request\Admin\AdminProfile\AdminProfileStateUpdateRequest;
use App\Response\Admin\AdminProfile\AdminProfileGetForSuperAdminResponse;
use App\Response\Admin\AdminProfile\AdminProfileUpdateResponse;
use App\Response\Admin\AdminProfileGetResponse;
use App\Service\FileUpload\UploadFileHelperService;

class AdminProfileService
{
    private AutoMapping $autoMapping;
    private AdminProfileManager $adminProfileManager;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, AdminProfileManager $adminProfileManager, UploadFileHelperService $uploadFileHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminProfileManager = $adminProfileManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
    }

    public function getAdminProfileByAdminUserId(int $adminUserId): ?AdminProfileGetResponse
    {
        $response = [];

        $adminProfile = $this->adminProfileManager->getAdminProfileByAdminUserId($adminUserId);

        if ($adminProfile) {
            $response = $this->autoMapping->map(AdminProfileEntity::class, AdminProfileGetResponse::class, $adminProfile);

            if ($response->image) {
                $response->image = $this->uploadFileHelperService->getImageParams($response->image->getImagePath());
            }
        }

        return $response;
    }

    public function updateAdminProfile(AdminProfileRequest $request): AdminProfileUpdateResponse
    {
        $adminProfile = $this->adminProfileManager->updateAdminProfile($request);

        return $this->autoMapping->map(AdminProfileEntity::class, AdminProfileUpdateResponse::class, $adminProfile);
    }

    public function updateAdminProfileState(AdminProfileStateUpdateRequest $request)
    {
        $adminProfileResult = $this->adminProfileManager->updateAdminProfileState($request);

        if ($adminProfileResult === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;

        } else {
            $response = [];

            $response = $this->autoMapping->map(AdminProfileEntity::class, AdminProfileGetForSuperAdminResponse::class, $adminProfileResult);

            if ($response->image) {
                $response->image = $this->uploadFileHelperService->getImageParams($response->image->getImagePath());
            }

            return $response;
        }
    }
}
