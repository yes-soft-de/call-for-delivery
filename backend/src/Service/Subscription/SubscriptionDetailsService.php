<?php

namespace App\Service\Subscription;

use App\Constant\Notification\SubscriptionFirebaseNotificationConstant;
use App\Entity\SubscriptionDetailsEntity;
use App\Manager\Subscription\SubscriptionDetailsManager;
use App\Service\Notification\SubscriptionFirebaseNotificationService;

class SubscriptionDetailsService
{
    private SubscriptionDetailsManager $subscriptionDetailsManager;
    private SubscriptionFirebaseNotificationService $subscriptionFirebaseNotificationService;

    public function __construct(SubscriptionDetailsManager $subscriptionDetailsManager, SubscriptionFirebaseNotificationService $subscriptionFirebaseNotificationService)
    {
        $this->subscriptionDetailsManager = $subscriptionDetailsManager;
        $this->subscriptionFirebaseNotificationService = $subscriptionFirebaseNotificationService;
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

    public function getSubscriptionDetailsEntityByLastSubscriptionId(int $subscriptionId): array
    {
        return $this->subscriptionDetailsManager->getSubscriptionDetailsEntityByLastSubscriptionId($subscriptionId);
    }

    public function updateRemainingCars(int $id, int $remainingCars): ?SubscriptionDetailsEntity
    {
        $subscriptionDetailsResult = $this->subscriptionDetailsManager->updateRemainingCars($id, $remainingCars);

        // Check if remaining cars has negative value, and inform admin if it is
        if ($subscriptionDetailsResult) {
            $this->chekRemainingCarsOfStoreSubscriptionAndInformAdmin($subscriptionDetailsResult->getRemainingOrders(),
                $subscriptionDetailsResult->getStoreOwner()->getStoreOwnerName());
        }

        return $subscriptionDetailsResult;
    }

    public function deleteSubscriptionDetailsBySubscriptionId(int $subscriptionId): ?SubscriptionDetailsEntity
    {
        return $this->subscriptionDetailsManager->deleteSubscriptionDetailsBySubscriptionId($subscriptionId);
    }

    // Check if remaining orders of a store subscription has negative value, and send firebase notification to admin if it is
    public function chekRemainingCarsOfStoreSubscriptionAndInformAdmin(int $remainingCars, int $storeOwnerName)
    {
        if ($remainingCars < 0) {
            // Notify admin by sending firebase notification to it
            $this->sendFirebaseNotificationToAdmin(SubscriptionFirebaseNotificationConstant::STORE_SUBSCRIPTION_REMAINING_CARS_NEGATIVE_VALUE_CONST,
                $storeOwnerName);
        }
    }

    // Send firebase notification to each admin about the event
    public function sendFirebaseNotificationToAdmin(string $notificationDescription, string $storeName): array
    {
        return $this->subscriptionFirebaseNotificationService->sendFirebaseNotificationToAdmin($notificationDescription, $storeName);
    }

    public function getSubscriptionDetailsByStoreOwnerProfileId(int $storeOwnerProfileId): ?SubscriptionDetailsEntity
    {
        return $this->subscriptionDetailsManager->getSubscriptionDetailsByStoreOwnerProfileId($storeOwnerProfileId);
    }

    // Note: factor is the parameter that we want to subtract/add from/to remaining cars field
    public function updateRemainingOrdersOfStoreSubscriptionBySubscriptionDetailsId(int $subscriptionDetailsId, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        return $this->subscriptionDetailsManager->updateRemainingOrdersOfStoreSubscriptionBySubscriptionDetailsId($subscriptionDetailsId,
            $operationType, $factor);
    }

    // Note: factor is the parameter that we want to subtract/add from/to remaining cars field
    public function updateRemainingCarsOfStoreSubscriptionBySubscriptionDetailsId(int $subscriptionDetailsId, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        return $this->subscriptionDetailsManager->updateRemainingCarsOfStoreSubscriptionBySubscriptionDetailsId($subscriptionDetailsId,
            $operationType, $factor);
    }
}
