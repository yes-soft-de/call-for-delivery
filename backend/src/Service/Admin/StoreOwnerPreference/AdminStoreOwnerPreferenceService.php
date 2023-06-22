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
use App\Service\Subscription\SubscriptionDetailsGetService;

class AdminStoreOwnerPreferenceService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminStoreOwnerPreferenceManager $adminStoreOwnerPreferenceManager,
        private AdminStoreOwnerProfileGetService $adminStoreOwnerProfileGetService,
        private SubscriptionDetailsGetService $subscriptionDetailsGetService
    )
    {
    }

    public function getStoreSubscriptionCurrentPackageIdByStoreOwnerProfileId(int $storeOwnerProfileId): int
    {
        return $this->subscriptionDetailsGetService->getStoreSubscriptionCurrentPackageIdByStoreOwnerProfileId($storeOwnerProfileId);
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

        $response = $this->autoMapping->map(StoreOwnerPreferenceEntity::class, StoreOwnerPreferenceGetForAdminResponse::class,
            $storeOwnerPreference);

        // check if store passed the payment of the opening package subscription
        // store pass the payment when it subscribed with the opening package or the uniform package
        // or when the admin approve the pass
        $storeOwnerProfile = $storeOwnerPreference->getStoreOwnerProfile();

        $packageId = $this->getStoreSubscriptionCurrentPackageIdByStoreOwnerProfileId($storeOwnerProfile->getId());

        if (($storeOwnerProfile->getOpeningSubscriptionWithoutPayment() === true)
            || (($packageId === 18) || ($packageId === 19))) {
            $response->openingPackagePaymentHasPassed = true;
        }

        return $response;
    }
}
