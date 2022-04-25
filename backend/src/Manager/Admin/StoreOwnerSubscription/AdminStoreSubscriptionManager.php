<?php

namespace App\Manager\Admin\StoreOwnerSubscription;

use App\Repository\SubscriptionEntityRepository;

class AdminStoreSubscriptionManager
{
    private SubscriptionEntityRepository $subscribeRepository;

    public function __construct(SubscriptionEntityRepository $subscribeRepository)
    {
        $this->subscribeRepository = $subscribeRepository;

    }

    public function getSubscriptionsSpecificStoreForAdmin(int $storeId): ?array
    {
        return $this->subscribeRepository->getSubscriptionsSpecificStoreForAdmin($storeId);
    }
}
