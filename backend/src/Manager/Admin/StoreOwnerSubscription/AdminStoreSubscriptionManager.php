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

    public function getCaptainOfferFirstTimeBySubscriptionId(int $subscriptionId): ?array
    {
        return $this->subscribeRepository->getCaptainOfferFirstTimeBySubscriptionId($subscriptionId);
    }

    public function getCaptainOffersBySubscriptionId(int $subscriptionId): ?array
    {
        return $this->subscribeRepository->getCaptainOffersBySubscriptionId($subscriptionId);
    }
}
