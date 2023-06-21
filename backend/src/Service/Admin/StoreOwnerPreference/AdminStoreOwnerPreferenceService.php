<?php

namespace App\Service\Admin\StoreOwnerPreference;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\StoreOwnerPreference\StoreOwnerPreferenceConstant;
use App\Entity\StoreOwnerPreferenceEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Manager\Admin\StoreOwnerPreference\AdminStoreOwnerPreferenceManager;
use App\Request\Admin\StoreOwnerPreference\StoreOwnerPreferenceCreateByAdminRequest;
use App\Request\Admin\StoreOwnerPreference\StoreOwnerPreferenceUpdateByAdminRequest;
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

    public function getStoreOwnerProfileEntityByIdForAdmin(int $id): string|StoreOwnerProfileEntity
    {
        return $this->adminStoreOwnerProfileGetService->getStoreOwnerProfileEntityByIdForAdmin($id);
    }

    public function createStoreOwnerPreferenceByAdmin(StoreOwnerPreferenceCreateByAdminRequest $request): string|StoreOwnerPreferenceGetForAdminResponse
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

    public function updateStoreOwnerPreferenceByAdmin(StoreOwnerPreferenceUpdateByAdminRequest $request): int|StoreOwnerPreferenceGetForAdminResponse
    {
        $storeOwnerPreference = $this->adminStoreOwnerPreferenceManager->updateStoreOwnerPreferenceByAdmin($request);

        if (! $storeOwnerPreference) {
            return StoreOwnerPreferenceConstant::STORE_OWNER_PREFERENCE_NOT_EXIST_CONST;
        }

        return $this->autoMapping->map(StoreOwnerPreferenceEntity::class, StoreOwnerPreferenceGetForAdminResponse::class,
            $storeOwnerPreference);
    }

    public function getStoreOwnerPreferenceByStoreOwnerProfileId(int $storeOwnerProfileId): int|StoreOwnerPreferenceGetForAdminResponse
    {
        $storeOwnerPreference = $this->adminStoreOwnerPreferenceManager->getStoreOwnerPreferenceByStoreOwnerProfileId($storeOwnerProfileId);

        if (! $storeOwnerPreference) {
            return StoreOwnerPreferenceConstant::STORE_OWNER_PREFERENCE_NOT_EXIST_CONST;
        }

        return $this->autoMapping->map(StoreOwnerPreferenceEntity::class, StoreOwnerPreferenceGetForAdminResponse::class,
            $storeOwnerPreference);
    }
}
