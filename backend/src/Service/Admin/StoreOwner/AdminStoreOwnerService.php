<?php

namespace App\Service\Admin\StoreOwner;

use App\AutoMapping;
use App\Manager\Admin\StoreOwner\AdminStoreOwnerManager;
use App\Response\Admin\StoreOwner\StoreOwnerProfileByIdGetByAdminResponse;
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
}
