<?php

namespace App\Service\Subscription;

use App\Manager\Subscription\SubscriptionHistoryManager;

class SubscriptionHistoryService
{
    private SubscriptionHistoryManager $subscriptionHistoryManager;

    public function __construct(SubscriptionHistoryManager $subscriptionHistoryManager)
    {
        $this->subscriptionHistoryManager = $subscriptionHistoryManager;
    }

    public function deleteSubscriptionHistoryByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->subscriptionHistoryManager->deleteSubscriptionHistoryByStoreOwnerId($storeOwnerId);
    }
}
