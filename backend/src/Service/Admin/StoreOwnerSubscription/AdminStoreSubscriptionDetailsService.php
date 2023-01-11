<?php

namespace App\Service\Admin\StoreOwnerSubscription;

use App\Constant\Subscription\SubscriptionConstant;
use App\Constant\Subscription\SubscriptionDetailsConstant;
use App\Entity\SubscriptionDetailsEntity;
use App\Entity\SubscriptionEntity;
use App\Manager\Admin\StoreOwnerSubscription\AdminSubscriptionDetailsManager;

class AdminStoreSubscriptionDetailsService
{
    private AdminSubscriptionDetailsManager $adminSubscriptionDetailsManager;

    public function __construct(AdminSubscriptionDetailsManager $adminSubscriptionDetailsManager)
    {
        $this->adminSubscriptionDetailsManager = $adminSubscriptionDetailsManager;
    }

    public function getSubscriptionDetailsByStoreOwnerProfileIdForAdmin(int $storeOwnerProfileId): ?SubscriptionDetailsEntity
    {
        return $this->adminSubscriptionDetailsManager->getSubscriptionDetailsByStoreOwnerProfileIdForAdmin($storeOwnerProfileId);
    }

    // Note: factor is the parameter that we want to subtract/add from/to remaining cars field
    public function updateRemainingCarsOfStoreSubscriptionBySubscriptionDetailsId($subscriptionDetails, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        $subscriptionDetailsResult = $this->adminSubscriptionDetailsManager->updateRemainingCarsOfStoreSubscriptionBySubscriptionDetailsId($subscriptionDetails,
            $operationType, $factor);

        return $subscriptionDetailsResult;
    }

    // Note: factor is the parameter that we want to subtract/add from/to remaining cars field
    public function updateRemainingOrdersOfStoreSubscriptionBySubscriptionDetailsId($subscriptionDetails, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        $subscriptionDetailsResult = $this->adminSubscriptionDetailsManager->updateRemainingOrdersOfStoreSubscriptionBySubscriptionDetailsId($subscriptionDetails,
            $operationType, $factor);

        return $subscriptionDetailsResult;
    }

//    public function getCurrentSubscriptionByStoreOwnerProfileIdForAdmin(int $storeOwnerProfileId): SubscriptionEntity|int|null
//    {
//        $subscriptionDetails = $this->getSubscriptionDetailsByStoreOwnerProfileIdForAdmin($storeOwnerProfileId);
//
//        if (! $subscriptionDetails) {
//            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
//        }
//
//        return $subscriptionDetails->getLastSubscription();
//    }
}
