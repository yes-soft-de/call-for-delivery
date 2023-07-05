<?php

namespace App\Service\Subscription;

use App\Constant\Subscription\SubscriptionDetailsConstant;
use App\Entity\SubscriptionDetailsEntity;
use App\Entity\SubscriptionEntity;
use App\Manager\Subscription\SubscriptionDetailsManager;

class SubscriptionDetailsGetService
{
    public function __construct(
        private SubscriptionDetailsManager $subscriptionDetailsManager
    )
    {
    }

    public function getStoreSubscriptionCurrentByStoreOwnerProfileId(int $storeOwnerProfileId): SubscriptionEntity|int
    {
        $subscriptionDetails = $this->subscriptionDetailsManager->getSubscriptionCurrent($storeOwnerProfileId);

        if (! $subscriptionDetails) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        return $subscriptionDetails->getLastSubscription();
    }

    public function getStoreSubscriptionCurrentPackageIdByStoreOwnerProfileId(int $storeOwnerProfileId): int
    {
        $subscription = $this->getStoreSubscriptionCurrentByStoreOwnerProfileId($storeOwnerProfileId);

        if ($subscription === SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        return $subscription->getPackage()->getId();
    }
}
