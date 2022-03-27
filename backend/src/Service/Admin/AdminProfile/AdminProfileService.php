<?php

namespace App\Service\Admin\AdminProfile;

use App\AutoMapping;
use App\Constant\Admin\AdminProfileConstant;
use App\Entity\AdminProfileEntity;
use App\Entity\UserEntity;
use App\Manager\Admin\AdminProfile\AdminProfileManager;
use App\Request\Admin\AdminProfile\AdminProfileRequest;
use App\Request\Admin\AdminProfile\AdminProfileStatusUpdateRequest;
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

            if (! empty($response->images->toArray())) {
                $response2 = [];

                foreach ($response->images->toArray() as $imageEntity) {
                    $response2[] = $this->uploadFileHelperService->getImageParams($imageEntity->getImagePath());
                }

                $response->images = $response2;

            } else {
                $response->images = null;
            }
        }

        return $response;
    }

    public function updateAdminProfile(AdminProfileRequest $request): string|AdminProfileUpdateResponse
    {
        $adminProfileResult = $this->adminProfileManager->updateAdminProfile($request);

        if ($adminProfileResult === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;

        } else {
            return $this->autoMapping->map(AdminProfileEntity::class, AdminProfileUpdateResponse::class, $adminProfileResult);
        }
    }

    public function updateAdminProfileStatus(AdminProfileStatusUpdateRequest $request): string|AdminProfileGetForSuperAdminResponse
    {
        $adminProfileResult = $this->adminProfileManager->updateAdminProfileStatus($request);

        if ($adminProfileResult === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;

        } else {
            $response = [];

            $response = $this->autoMapping->map(AdminProfileEntity::class, AdminProfileGetForSuperAdminResponse::class, $adminProfileResult);

            $response->user = $this->getSpecificUserFields($response->user);

            if ($response->image) {
                $response->image = $this->uploadFileHelperService->getImageParams($response->image->getImagePath());
            }

            return $response;
        }
    }

    public function updateAdminProfileBySuperAdmin(AdminProfileRequest $request): string|AdminProfileUpdateResponse
    {
        $adminProfileResult = $this->adminProfileManager->updateAdminProfileBySuperAdmin($request);

        if ($adminProfileResult === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;

        } else {
            return $this->autoMapping->map(AdminProfileEntity::class, AdminProfileUpdateResponse::class, $adminProfileResult);
        }
    }

    public function getSpecificUserFields(UserEntity $userEntity): array
    {
        $response = [];

        $response['id'] = $userEntity->getId();
        $response['userId'] = $userEntity->getUserId();
        $response['roles'] = $userEntity->getRoles();

        return $response;
    }
}
