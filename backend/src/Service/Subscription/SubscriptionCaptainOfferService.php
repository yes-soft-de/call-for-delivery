<?php

namespace App\Service\Subscription;

use App\AutoMapping;
use App\Constant\Subscription\SubscriptionConstant;
use App\Constant\Subscription\SubscriptionCaptainOffer;
use App\Entity\SubscriptionCaptainOfferEntity;
use App\Manager\Subscription\SubscriptionCaptainOfferManager;
use App\Request\Subscription\SubscriptionCaptainOfferCreateRequest;
use App\Response\Subscription\SubscriptionCaptainOfferCreateResponse;
use App\Response\Subscription\SubscriptionIsReadyResponse;
use App\Service\Notification\NotificationFirebaseService;

class SubscriptionCaptainOfferService
{
    private AutoMapping $autoMapping;
    private SubscriptionCaptainOfferManager $subscriptionCaptainOfferManager;
    private NotificationFirebaseService $notificationFirebaseService;

    public function __construct(AutoMapping $autoMapping, SubscriptionCaptainOfferManager $subscriptionCaptainOfferManager, NotificationFirebaseService $notificationFirebaseService)
    {
        $this->autoMapping = $autoMapping;
        $this->subscriptionCaptainOfferManager = $subscriptionCaptainOfferManager;
        $this->notificationFirebaseService = $notificationFirebaseService;
    }

    public function createSubscriptionCaptainOffer(SubscriptionCaptainOfferCreateRequest $request): SubscriptionCaptainOfferCreateResponse|SubscriptionIsReadyResponse 
    {
        $canCreateSubscriptionCaptainOffer = $this->isThereSubscription($request->getStoreOwner());

        if($canCreateSubscriptionCaptainOffer->subscriptionState === SubscriptionConstant::SUBSCRIPTION_NOT_FOUND || $canCreateSubscriptionCaptainOffer->subscriptionState === SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_CAN_NOT_SUBSCRIPTION) {

            return  $canCreateSubscriptionCaptainOffer;
        }

        $captainOffer = $this->subscriptionCaptainOfferManager->createSubscriptionCaptainOffer($request);

        // send two firebase notifications to admin
        $this->sendDoubledFirebaseNotificationToAdmin($request->getStoreOwner()->getStoreOwnerName(), $request->getCaptainOffer()->getId());

        return $this->autoMapping->map(SubscriptionCaptainOfferEntity::class, SubscriptionCaptainOfferCreateResponse::class, $captainOffer);
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
}
