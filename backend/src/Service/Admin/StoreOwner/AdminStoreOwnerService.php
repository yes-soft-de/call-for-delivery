<?php

namespace App\Service\Admin\StoreOwner;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Manager\Admin\StoreOwner\AdminStoreOwnerManager;
use App\Request\Admin\Report\StoresAndOrdersCountDuringSpecificTimeFilterByAdminRequest;
use App\Request\Admin\StoreOwner\DeleteStoreOwnerAccountAndProfileByAdminRequest;
use App\Request\Admin\StoreOwner\StoreOwnerProfileStatusUpdateByAdminRequest;
use App\Request\Admin\StoreOwner\StoreOwnerProfileUpdateByAdminRequest;
use App\Response\Admin\StoreOwner\StoreOwnerProfileByIdGetByAdminResponse;
use App\Response\Admin\StoreOwner\StoreOwnerProfileGetByAdminResponse;
use App\Response\Eraser\DeleteStoreOwnerAccountAndProfileByAdminResponse;
use App\Service\CompanyInfo\CompanyInfoService;
use App\Service\Eraser\StoreOwner\StoreOwnerEraserService;
use App\Service\FileUpload\UploadFileHelperService;

class AdminStoreOwnerService
{
    private AutoMapping $autoMapping;
    private AdminStoreOwnerManager $adminStoreOwnerManager;
    private UploadFileHelperService $uploadFileHelperService;
    private CompanyInfoService $companyInfoService;
    private StoreOwnerEraserService $storeOwnerEraserService;

    public function __construct(AutoMapping $autoMapping, AdminStoreOwnerManager $adminStoreOwnerManager, UploadFileHelperService $uploadFileHelperService,
                                CompanyInfoService $companyInfoService, StoreOwnerEraserService $storeOwnerEraserService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminStoreOwnerManager = $adminStoreOwnerManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
        $this->companyInfoService = $companyInfoService;
        $this->storeOwnerEraserService = $storeOwnerEraserService;
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

    /**
     * Gets store owners' profiles according to status
     */
    public function getStoreOwnersProfilesByStatusForAdmin(string $storeOwnerProfileStatus): array
    {
        $response = [];

        $storeOwnerProfiles = $this->adminStoreOwnerManager->getStoreOwnersProfilesByStatusForAdmin($storeOwnerProfileStatus);

        if ($storeOwnerProfiles) {
            foreach($storeOwnerProfiles as $key => $value) {
                $value['images'] = $this->uploadFileHelperService->getImageParams($value['images']);

                $response[$key] = $this->autoMapping->map('array', StoreOwnerProfileGetByAdminResponse::class, $value);

                // get package type of the current store subscription
                if ($value['storeSubscriptionDetails']) {
                    $response[$key]->packageType = $value['storeSubscriptionDetails']->getLastSubscription()->getPackage()->getType();
                }
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

    public function deleteStoreOwnerAccountAndProfileByAdmin(DeleteStoreOwnerAccountAndProfileByAdminRequest $request): int|DeleteStoreOwnerAccountAndProfileByAdminResponse|null
    {
        return $this->storeOwnerEraserService->deleteStoreOwnerAccountAndProfileByAdmin($request);
    }

    public function getStoreOwnerProfileEntityByStoreOwnerId(int $storeOwnerId): ?StoreOwnerProfileEntity
    {
        return $this->adminStoreOwnerManager->getStoreOwnerProfileEntityByStoreOwnerId($storeOwnerId);
    }

    // Get top stores according on delivered orders during specific time
    public function filterTopStoresAccordingOnOrdersByAdmin(StoresAndOrdersCountDuringSpecificTimeFilterByAdminRequest $request): array
    {
        return $this->adminStoreOwnerManager->filterTopStoresAccordingOnOrdersByAdmin($request);
    }
}
