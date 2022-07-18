<?php

namespace App\Service\Subscription;

use App\Manager\Subscription\SubscriptionDetailsManager;
//use App\Response\Subscription\SubscriptionDetailsResponse;

class SubscriptionDetailsService
{
    private SubscriptionDetailsManager $subscriptionDetailsManager;

    public function __construct(SubscriptionDetailsManager $subscriptionDetailsManager)
    {
        $this->subscriptionDetailsManager = $subscriptionDetailsManager;
    }

    /**
     * The following function is commented out because it is not being used anywhere, besides the response which
     * is using is not exists anymore!
     */
//    /**
//     * @param SubscriptionDetailsCreateRequest $request
//     * @return mixed
//     * @throws NonUniqueResultException
//     */
//    public function createSubscriptionDetails(SubscriptionDetailsCreateRequest $request): mixed
//    {
//        $subscriptionResult = $this->subscriptionDetailsManager->createSubscriptionDetails($request);
//
//        return $this->autoMapping->map(SubscriptionDetailsEntity::class, SubscriptionDetailsResponse::class, $subscriptionResult);
//    }

    public function deleteSubscriptionDetailsByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->subscriptionDetailsManager->deleteSubscriptionDetailsByStoreOwnerId($storeOwnerId);
    }
}
