<?php

namespace App\Service\Eraser\Subscription;

use App\Constant\Admin\Subscription\AdminStoreSubscriptionConstant;
use App\Service\Subscription\SubscriptionCaptainOfferService;
use App\Service\Subscription\SubscriptionDetailsService;
use App\Service\Subscription\SubscriptionHistoryService;
use App\Service\Subscription\SubscriptionService;

class StoreSubscriptionEraserService
{
    private SubscriptionHistoryService $subscriptionHistoryService;
    private SubscriptionDetailsService $subscriptionDetailsService;
    private SubscriptionService $subscriptionService;
    private SubscriptionCaptainOfferService $subscriptionCaptainOfferService;

    public function __construct(SubscriptionHistoryService $subscriptionHistoryService, SubscriptionDetailsService $subscriptionDetailsService, SubscriptionService $subscriptionService,
                                SubscriptionCaptainOfferService $subscriptionCaptainOfferService)
    {
        $this->subscriptionHistoryService = $subscriptionHistoryService;
        $this->subscriptionDetailsService = $subscriptionDetailsService;
        $this->subscriptionService = $subscriptionService;
        $this->subscriptionCaptainOfferService = $subscriptionCaptainOfferService;
    }

    /**
     * This function deletes all store subscriptions and their related data in subscription history,
     * subscription details, subscription entity, only when no payments related to any subscription are exist
     */
    public function deleteStoreOwnerSubscription(int $storeOwnerId): int
    {
//        // first, check if there are any payments related to any one of store subscriptions
//        $paymentsExistsResult = $this->subscriptionService->checkIfStoreSubscriptionsHavePayments($storeOwnerId);
//
//        if ($paymentsExistsResult === AdminStoreSubscriptionConstant::STORE_SUBSCRIPTION_HAS_PAYMENTS) {
//            return AdminStoreSubscriptionConstant::STORE_SUBSCRIPTION_HAS_PAYMENTS;
//        }

        // No payments are exists, we can continue in deleting store subscription process >>>
        // second, delete subscription/s history
        $this->subscriptionHistoryService->deleteSubscriptionHistoryByStoreOwnerId($storeOwnerId);

        // third, delete subscription details
        $subscriptionDetailsResults = $this->subscriptionDetailsService->deleteSubscriptionDetailsByStoreOwnerId($storeOwnerId);
        //dd($subscriptionDetailsResults);
        $this->subscriptionCaptainOfferService->deleteCaptainOffersSubscriptionsByStoreOwnerId($storeOwnerId);

        $this->subscriptionService->deleteStoreSubscriptionByStoreOwnerId($storeOwnerId);

        return AdminStoreSubscriptionConstant::STORE_SUBSCRIPTIONS_DELETED_SUCCESSFULLY;
    }
}
