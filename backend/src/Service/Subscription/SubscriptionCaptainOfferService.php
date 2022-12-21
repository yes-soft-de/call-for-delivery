<?php

namespace App\Service\Subscription;

use App\AutoMapping;
use App\Constant\Notification\SubscriptionFirebaseNotificationConstant;
use App\Constant\Subscription\SubscriptionConstant;
use App\Constant\Subscription\SubscriptionCaptainOffer;
use App\Entity\SubscriptionCaptainOfferEntity;
use App\Manager\Subscription\SubscriptionCaptainOfferManager;
use App\Request\Subscription\SubscriptionCaptainOfferCreateRequest;
use App\Response\Subscription\SubscriptionCaptainOfferCreateResponse;
use App\Response\Subscription\SubscriptionIsReadyResponse;
use App\Service\Notification\CaptainOfferSubscriptionFirebaseNotificationService;
use App\Service\Notification\NotificationFirebaseService;

class SubscriptionCaptainOfferService
{
    private AutoMapping $autoMapping;
    private SubscriptionCaptainOfferManager $subscriptionCaptainOfferManager;
    private NotificationFirebaseService $notificationFirebaseService;
    private CaptainOfferSubscriptionFirebaseNotificationService $captainOfferSubscriptionFirebaseNotificationService;

    public function __construct(AutoMapping $autoMapping, SubscriptionCaptainOfferManager $subscriptionCaptainOfferManager, NotificationFirebaseService $notificationFirebaseService,
                                CaptainOfferSubscriptionFirebaseNotificationService $captainOfferSubscriptionFirebaseNotificationService)
    {
        $this->autoMapping = $autoMapping;
        $this->subscriptionCaptainOfferManager = $subscriptionCaptainOfferManager;
        $this->notificationFirebaseService = $notificationFirebaseService;
        $this->captainOfferSubscriptionFirebaseNotificationService = $captainOfferSubscriptionFirebaseNotificationService;
    }

    public function createSubscriptionCaptainOffer(SubscriptionCaptainOfferCreateRequest $request): SubscriptionCaptainOfferCreateResponse|SubscriptionIsReadyResponse 
    {
        $canCreateSubscriptionCaptainOffer = $this->isThereSubscription($request->getStoreOwner());

        if($canCreateSubscriptionCaptainOffer->subscriptionState === SubscriptionConstant::SUBSCRIPTION_NOT_FOUND || $canCreateSubscriptionCaptainOffer->subscriptionState === SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_CAN_NOT_SUBSCRIPTION) {
            return  $canCreateSubscriptionCaptainOffer;
        }

        $arrayResult = $this->subscriptionCaptainOfferManager->createSubscriptionCaptainOffer($request);

        // send two firebase notifications to admin
        $this->sendDoubledFirebaseNotificationToAdmin($request->getStoreOwner()->getStoreOwnerName(), $request->getCaptainOffer()->getId());

        // Check if remaining cars had negative value, and inform admin if it has
        if ($arrayResult[1] !== SubscriptionConstant::ERROR) {
            $subscriptionDetailsResult = $arrayResult[1][1];

            if ($subscriptionDetailsResult) {
                $this->checkRemainingCarsOfStoreSubscriptionAndInformAdmin($subscriptionDetailsResult->getRemainingCars(),
                    $subscriptionDetailsResult->getStoreOwner()->getStoreOwnerName());
            }
        }

        return $this->autoMapping->map(SubscriptionCaptainOfferEntity::class, SubscriptionCaptainOfferCreateResponse::class, $arrayResult[0]);
    }

    public function updateState(int $id, string $status): ?SubscriptionCaptainOfferEntity
    {
        return $this->subscriptionCaptainOfferManager->updateState($id, $status);
    }

    public function isThereSubscription(int $storeOwnerId): SubscriptionIsReadyResponse
    {
        $subscribe = $this->subscriptionCaptainOfferManager->isThereSubscription($storeOwnerId);
        if(!$subscribe ) {

            $subscribe['subscriptionState'] = SubscriptionConstant::SUBSCRIPTION_NOT_FOUND;
         }

        else {
            
            $subscriptionCaptainOffer = $this->subscriptionCaptainOfferManager->subscriptionCaptainOfferBySubscribeId($subscribe['lastSubscription']);
            if($subscriptionCaptainOffer) {
                if($subscriptionCaptainOffer['status'] === SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_ACTIVE){
                
                    $subscribe['subscriptionState'] = SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_CAN_NOT_SUBSCRIPTION;
                }
            } 
        }
        
         return $this->autoMapping->map("array", SubscriptionIsReadyResponse::class, $subscribe);
    }

    public function sendDoubledFirebaseNotificationToAdmin(string $storeOwnerName, int $captainOfferId)
    {
        for ($i = 0; $i < 2; $i++)
        {
            $this->notificationFirebaseService->notificationCreateCaptainOfferSubscriptionToAdmin($storeOwnerName, $captainOfferId);
        }
    }

    public function deleteCaptainOffersSubscriptionsByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->subscriptionCaptainOfferManager->deleteCaptainOffersSubscriptionsByStoreOwnerId($storeOwnerId);
    }

    public function deleteCaptainOfferSubscriptionById(int $id): ?SubscriptionCaptainOfferEntity
    {
        return $this->subscriptionCaptainOfferManager->deleteCaptainOfferSubscriptionById($id);
    }

    public function deleteCaptainOffersSubscriptionBySubscriptionId(int $subscriptionId): ?SubscriptionCaptainOfferEntity
    {
        return $this->subscriptionCaptainOfferManager->deleteCaptainOffersSubscriptionBySubscriptionId($subscriptionId);
    }

    public function sendFirebaseNotificationToAdmin(string $notificationDescription, string $storeOwnerName): array
    {
        return $this->captainOfferSubscriptionFirebaseNotificationService->sendFirebaseNotificationToAdmin($notificationDescription,
            $storeOwnerName);
    }

    public function checkRemainingCarsOfStoreSubscriptionAndInformAdmin(int $remainingCars, string $storeOwnerName)
    {
        if ($remainingCars < 0) {
            // Notify admin by firebase notification
            $this->sendFirebaseNotificationToAdmin(SubscriptionFirebaseNotificationConstant::STORE_SUBSCRIPTION_REMAINING_CARS_NEGATIVE_VALUE_CONST,
                $storeOwnerName);
        }
    }
}
