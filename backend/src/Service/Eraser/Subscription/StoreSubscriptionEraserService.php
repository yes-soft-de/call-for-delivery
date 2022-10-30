<?php

namespace App\Service\Eraser\Subscription;

use App\Constant\Admin\Subscription\AdminStoreSubscriptionConstant;
use App\Service\Subscription\SubscriptionCaptainOfferService;
use App\Service\Subscription\SubscriptionDetailsService;
use App\Service\Subscription\SubscriptionHistoryService;
use App\Service\Subscription\SubscriptionService;
use Doctrine\ORM\EntityManagerInterface;

class StoreSubscriptionEraserService
{
    private SubscriptionHistoryService $subscriptionHistoryService;
    private SubscriptionDetailsService $subscriptionDetailsService;
    private SubscriptionService $subscriptionService;
    private SubscriptionCaptainOfferService $subscriptionCaptainOfferService;
    private EntityManagerInterface $entityManager;

    public function __construct(SubscriptionHistoryService $subscriptionHistoryService, SubscriptionDetailsService $subscriptionDetailsService, SubscriptionService $subscriptionService,
                                SubscriptionCaptainOfferService $subscriptionCaptainOfferService, EntityManagerInterface $entityManager)
    {
        $this->subscriptionHistoryService = $subscriptionHistoryService;
        $this->subscriptionDetailsService = $subscriptionDetailsService;
        $this->subscriptionService = $subscriptionService;
        $this->subscriptionCaptainOfferService = $subscriptionCaptainOfferService;
        $this->entityManager = $entityManager;
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

        $this->subscriptionCaptainOfferService->deleteCaptainOffersSubscriptionsByStoreOwnerId($storeOwnerId);

        $this->subscriptionService->deleteStoreSubscriptionByStoreOwnerId($storeOwnerId);

        return AdminStoreSubscriptionConstant::STORE_SUBSCRIPTIONS_DELETED_SUCCESSFULLY;
    }

    /**
     * This function deletes all store subscriptions and their related data in subscription history,
     * subscription details, subscription entity, only when no payments related to any subscription are exist
     */
    public function deleteCurrentStoreOwnerSubscriptionBySubscriptionId(int $subscriptionId): int
    {
        $this->entityManager->getConnection()->beginTransaction();

        try {
            // delete subscription history
            $this->subscriptionHistoryService->deleteSubscriptionHistoryBySubscriptionId($subscriptionId);

            // delete subscription details
            $this->subscriptionDetailsService->deleteSubscriptionDetailsBySubscriptionId($subscriptionId);

            // delete captain offer subscription if exists
            $this->subscriptionCaptainOfferService->deleteCaptainOffersSubscriptionBySubscriptionId($subscriptionId);

            // delete subscription entity itself
            $this->subscriptionService->deleteStoreSubscriptionBySubscriptionId($subscriptionId);

            $this->entityManager->getConnection()->commit();

            return AdminStoreSubscriptionConstant::STORE_SUBSCRIPTIONS_DELETED_SUCCESSFULLY;

        } catch (\Exception $e) {
            $this->entityManager->getConnection()->rollBack();
            throw $e;
        }
    }
}
