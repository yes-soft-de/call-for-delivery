<?php

namespace App\Service\Subscription;

use App\Entity\SubscriptionHistoryEntity;
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

    public function deleteSubscriptionHistoryBySubscriptionId(int $subscriptionId): ?SubscriptionHistoryEntity
    {
        return $this->subscriptionHistoryManager->deleteSubscriptionHistoryBySubscriptionId($subscriptionId);
    }
}
