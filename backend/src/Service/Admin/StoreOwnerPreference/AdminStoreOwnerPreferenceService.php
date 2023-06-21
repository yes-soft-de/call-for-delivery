<?php

namespace App\Service\Admin\StoreOwnerPreference;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Entity\StoreOwnerPreferenceEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Manager\Admin\StoreOwnerPreference\AdminStoreOwnerPreferenceManager;
use App\Request\Admin\StoreOwnerPreference\StoreOwnerPreferenceCreateByAdminRequest;
use App\Response\Admin\StoreOwnerPreference\StoreOwnerPreferenceGetForAdminResponse;
use App\Service\Admin\StoreOwner\AdminStoreOwnerProfileGetService;

class AdminStoreOwnerPreferenceService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminStoreOwnerPreferenceManager $adminStoreOwnerPreferenceManager,
        private AdminStoreOwnerProfileGetService $adminStoreOwnerProfileGetService
    )
    {
    }

    public function getStoreOwnerProfileEntityByIdForAdmin(int $id): string|StoreOwnerPreferenceGetForAdminResponse
    {
        return $this->adminStoreOwnerProfileGetService->getStoreOwnerProfileEntityByIdForAdmin($id);
    }

    public function createStoreOwnerPreferenceByAdmin(StoreOwnerPreferenceCreateByAdminRequest $request)
    {
        // get and set store owner profile entity
        $storeOwnerProfile = $this->getStoreOwnerProfileEntityByIdForAdmin($request->getStoreOwnerProfile());

        if ($storeOwnerProfile === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        $request->setStoreOwnerProfile($storeOwnerProfile);

        $storeOwnerPreference = $this->adminStoreOwnerPreferenceManager->createStoreOwnerPreferenceByAdmin($request);

        return $this->autoMapping->map(StoreOwnerPreferenceEntity::class, StoreOwnerPreferenceGetForAdminResponse::class,
            $storeOwnerPreference);
    }
}
