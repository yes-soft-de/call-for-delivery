<?php

namespace App\Service\Admin\StoreOwnerSubscription;

use App\Manager\Admin\StoreOwnerSubscription\AdminStoreSubscriptionManager;

class AdminStoreSubscriptionGetService
{
    public function __construct(
        private AdminStoreSubscriptionManager $adminStoreSubscriptionManager
    )
    {
    }

    public function getLastStoreSubscriptionByStoreOwnerProfileIdForAdmin(int $storeOwnerProfileId): array
    {
        return $this->adminStoreSubscriptionManager->getLastStoreSubscriptionByStoreOwnerProfileIdForAdmin($storeOwnerProfileId);
    }

    public function getDeliveredOrdersDeliveryCostAccordingToSubscriptionStartAndEndDatesForAdmin(int $storeOwnerProfileId, int $subscriptionId)
    {
        return $this->adminStoreSubscriptionManager->getDeliveredOrdersDeliveryCostAccordingToSubscriptionStartAndEndDatesForAdmin($storeOwnerProfileId,
            $subscriptionId);
    }

    public function getLastStoreSubscriptionCostForAdmin(int $storeOwnerProfileId): float
    {
        $subscriptionCost = 0.0;

        // 1 Get last store subscription (package id, start date, end date)
        $storeSubscriptionArray = $this->getLastStoreSubscriptionByStoreOwnerProfileIdForAdmin($storeOwnerProfileId);

        if (count($storeSubscriptionArray) === 0) {
            return $subscriptionCost;
        }

        $subscription = $storeSubscriptionArray[0];

        if ($subscription->getPackage()->getId() === 19) {
            // 2 if package id is 19 , then calculate the subscription cost
            $ordersCosts = $this->getDeliveredOrdersDeliveryCostAccordingToSubscriptionStartAndEndDatesForAdmin($storeOwnerProfileId,
                $subscription->getId());

            if (count($ordersCosts) > 0) {
                foreach ($ordersCosts as $orderCost) {
                    $subscriptionCost += $orderCost['deliveryCost'];
                }
            }
        }

        return $subscriptionCost;
    }
}
