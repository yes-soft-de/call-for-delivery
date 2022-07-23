<?php

namespace App\Service\Admin\StoreOwner;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Manager\Admin\StoreOwner\AdminStoreOwnerManager;
use App\Request\Admin\StoreOwner\StoreOwnerProfileStatusUpdateByAdminRequest;
use App\Request\Admin\StoreOwner\StoreOwnerProfileUpdateByAdminRequest;
use App\Response\Admin\StoreOwner\StoreOwnerProfileByIdGetByAdminResponse;
use App\Response\Admin\StoreOwner\StoreOwnerProfileGetByAdminResponse;
use App\Service\CompanyInfo\CompanyInfoService;
use App\Service\FileUpload\UploadFileHelperService;

class AdminStoreOwnerService
{
    private AutoMapping $autoMapping;
    private AdminStoreOwnerManager $adminStoreOwnerManager;
    private UploadFileHelperService $uploadFileHelperService;
    private CompanyInfoService $companyInfoService;

    public function __construct(AutoMapping $autoMapping, AdminStoreOwnerManager $adminStoreOwnerManager, UploadFileHelperService $uploadFileHelperService, CompanyInfoService $companyInfoService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminStoreOwnerManager = $adminStoreOwnerManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
        $this->companyInfoService = $companyInfoService;
    }

    public function getStoreOwnerProfileByIdForAdmin(int $storeOwnerProfileId): ?StoreOwnerProfileByIdGetByAdminResponse
    {
        $storeOwnerProfile = $this->adminStoreOwnerManager->getStoreOwnerProfileByIdForAdmin($storeOwnerProfileId);

        if ($storeOwnerProfile) {
            // check if there is no private margin for the store, then get the common one
            if ($storeOwnerProfile['profitMargin'] === null) {
                $storeOwnerProfile['profitMargin'] = $this->companyInfoService->getStoreProfitMargin()['storeProfitMargin'];
            }

            $storeOwnerProfile['images'] = $this->uploadFileHelperService->getImageParams($storeOwnerProfile['images']);

            if ($storeOwnerProfile['roomId']) {
                $storeOwnerProfile['roomId'] = $storeOwnerProfile['roomId']->toBase32();
            }
        }

        $storeOwnerProfile['branches'] = $this->adminStoreOwnerManager->getStoreOwnerBranchesByStoreOwnerProfileIdForAdmin($storeOwnerProfileId);

        return $this->autoMapping->map('array', StoreOwnerProfileByIdGetByAdminResponse::class, $storeOwnerProfile);
    }

    public function getStoreOwnersProfilesCountByStatusForAdmin(string $storeOwnerProfileStatus): int
    {
        return $this->adminStoreOwnerManager->getStoreOwnersProfilesCountByStatusForAdmin($storeOwnerProfileStatus);
    }

    public function getStoreOwnersProfilesByStatusForAdmin(string $storeOwnerProfileStatus): array
    {
        $response = [];

        $storeOwnerProfiles = $this->adminStoreOwnerManager->getStoreOwnersProfilesByStatusForAdmin($storeOwnerProfileStatus);

        if($storeOwnerProfiles) {
            foreach($storeOwnerProfiles as $storeOwnerProfile) {
                $storeOwnerProfile['images'] = $this->uploadFileHelperService->getImageParams($storeOwnerProfile['images']);

                $response[] = $this->autoMapping->map('array', StoreOwnerProfileGetByAdminResponse::class, $storeOwnerProfile);
            }
        }

        return $response;
    }

    public function updateStoreOwnerProfileStatusByAdmin(StoreOwnerProfileStatusUpdateByAdminRequest $request): string|StoreOwnerProfileGetByAdminResponse
    {
        $storeOwnerProfile = $this->adminStoreOwnerManager->updateStoreOwnerProfileStatusByAdmin($request);

        if ($storeOwnerProfile === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        return $this->autoMapping->map(StoreOwnerProfileEntity::class, StoreOwnerProfileGetByAdminResponse::class, $storeOwnerProfile);
    }

    public function updateStoreOwnerProfileByAdmin(StoreOwnerProfileUpdateByAdminRequest $request): string|StoreOwnerProfileGetByAdminResponse
    {
        $storeOwnerProfile = $this->adminStoreOwnerManager->updateStoreOwnerProfileByAdmin($request);

        if ($storeOwnerProfile === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        return $this->autoMapping->map(StoreOwnerProfileEntity::class, StoreOwnerProfileGetByAdminResponse::class, $storeOwnerProfile);
    }

    public function getLastThreeActiveStoreOwnersProfilesForAdmin(): array
    {
        $storesProfiles = $this->adminStoreOwnerManager->getLastThreeActiveStoreOwnersProfilesForAdmin();

        if (! empty($storesProfiles)) {
            foreach ($storesProfiles as $key => $value) {
                $storesProfiles[$key]['images'] = $this->uploadFileHelperService->getImageParams($value['images']);
            }
        }

        return $storesProfiles;
    }
}
