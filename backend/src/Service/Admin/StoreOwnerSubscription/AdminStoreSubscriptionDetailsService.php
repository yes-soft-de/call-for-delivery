<?php

namespace App\Service\Admin\StoreOwnerSubscription;

use App\Entity\SubscriptionDetailsEntity;
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
    public function updateRemainingCarsOfStoreSubscriptionBySubscriptionDetailsId(int $subscriptionDetailsId, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        return $this->adminSubscriptionDetailsManager->updateRemainingCarsOfStoreSubscriptionBySubscriptionDetailsId($subscriptionDetailsId,
            $operationType, $factor);
    }

    // Note: factor is the parameter that we want to subtract/add from/to remaining cars field
    public function updateRemainingOrdersOfStoreSubscriptionBySubscriptionDetailsId(int $subscriptionDetailsId, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        return $this->adminSubscriptionDetailsManager->updateRemainingOrdersOfStoreSubscriptionBySubscriptionDetailsId($subscriptionDetailsId,
            $operationType, $factor);
    }
}
