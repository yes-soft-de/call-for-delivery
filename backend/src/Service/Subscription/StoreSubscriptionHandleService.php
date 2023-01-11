<?php

namespace App\Service\Subscription;

use App\Constant\Subscription\SubscriptionConstant;
use App\Constant\Subscription\SubscriptionDetailsConstant;
use App\Entity\SubscriptionDetailsEntity;
use App\Entity\SubscriptionEntity;
use App\Manager\Subscription\SubscriptionManager;
use DateTime;

class StoreSubscriptionHandleService
{
    private SubscriptionManager $subscriptionManager;

    public function __construct(SubscriptionManager $subscriptionManager)
    {
        $this->subscriptionManager = $subscriptionManager;
    }

    // Check store subscription (cars, orders, etc.) and update its status
    public function checkStoreSubscriptionValidationBySubscriptionDetailsEntity(SubscriptionDetailsEntity $subscriptionDetails)
    {
        if (! $subscriptionDetails) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        // 1. Check subscription date
        $subscriptionDateValidationResult = $this->checkSubscriptionDate($subscriptionDetails->getLastSubscription(), $subscriptionDetails->getHasExtra());

        // 2. Check subscription orders
        $subscriptionOrdersValidationResult = $this->checkRemainingOrdersBySubscriptionDetailsEntity($subscriptionDetails);

        // 3. Check subscription cars
        $subscriptionCarsValidationResult = $this->checkSubscriptionRemainingCarsBySubscriptionDetailsEntity($subscriptionDetails);

        // We have to decide how to update the subscription status or the subscription itself
    }

    public function checkSubscriptionDate(SubscriptionEntity $subscription, bool $hasExtra): string
    {
        if ($subscription) {
            $dateNow = new DateTime('now');

            $endDate = $subscription->getEndDate();

            if ($hasExtra === SubscriptionConstant::IS_HAS_EXTRA_TRUE) {
                $endDate = new DateTime($subscription->getStartDate()->format('Y-m-d h:i:s') . '1 day');
            }

            // check if the subscription has expired
            if ($endDate < $dateNow ) {
                return SubscriptionConstant::DATE_FINISHED;
            }

            return SubscriptionConstant::SUBSCRIPTION_OK;
        }

        return SubscriptionConstant::YOU_DO_NOT_HAVE_SUBSCRIBED;
    }

    public function checkSubscriptionRemainingCarsBySubscriptionDetailsEntity(SubscriptionDetailsEntity $subscriptionDetails): int|string
    {
        if (! $subscriptionDetails) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        if ($subscriptionDetails->getRemainingCars() <= 0) {
            return SubscriptionConstant::CARS_FINISHED;
        }

        return SubscriptionConstant::SUBSCRIPTION_OK;
    }

    public function checkRemainingOrdersBySubscriptionDetailsEntity(SubscriptionDetailsEntity $subscriptionDetails): int|string
    {
        if (! $subscriptionDetails) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        if ($subscriptionDetails->getRemainingOrders() <= 0) {
            return SubscriptionConstant::ORDERS_FINISHED;
        }

        return SubscriptionConstant::SUBSCRIPTION_OK;
    }

    public function getFutureSubscription(int $storeOwnerProfileId): array
    {
        return $this->subscriptionManager->getFutureSubscriptionByStoreOwnerProfileId($storeOwnerProfileId);
    }
}
