<?php

namespace App\Service\Subscription;

use App\AutoMapping;
use App\Constant\Subscription\SubscriptionConstant;
use App\Entity\SubscriptionCaptainOfferEntity;
use App\Manager\Subscription\SubscriptionCaptainOfferManager;
use App\Request\Subscription\SubscriptionCaptainOfferCreateRequest;
use App\Response\Subscription\SubscriptionCaptainOfferCreateResponse;
use App\Response\Subscription\SubscriptionIsReadyResponse;

class SubscriptionCaptainOfferService
{
    private AutoMapping $autoMapping;
    private SubscriptionCaptainOfferManager $subscriptionCaptainOfferManager;

    public function __construct(AutoMapping $autoMapping, SubscriptionCaptainOfferManager $subscriptionCaptainOfferManager)
    {
        $this->autoMapping = $autoMapping;
        $this->subscriptionCaptainOfferManager = $subscriptionCaptainOfferManager;
    }

    public function createSubscriptionCaptainOffer(SubscriptionCaptainOfferCreateRequest $request): SubscriptionCaptainOfferCreateResponse|SubscriptionIsReadyResponse 
    {
        $canCreateSubscriptionCaptainOffer = $this->isSubscriptionForReady($request->getStoreOwner()); 
     
        if($canCreateSubscriptionCaptainOffer->subscriptionState === SubscriptionConstant::SUBSCRIPTION_NOT_FOUND) {
      
            return  $canCreateSubscriptionCaptainOffer;
        }

        $captainOffer = $this->subscriptionCaptainOfferManager->createSubscriptionCaptainOffer($request);

        return $this->autoMapping->map(SubscriptionCaptainOfferEntity::class, SubscriptionCaptainOfferCreateResponse::class, $captainOffer);
    }

    public function updateState(int $id, string $status): ?SubscriptionCaptainOfferEntity
    {
        return $this->subscriptionCaptainOfferManager->updateState($id, $status);
    }

    public function isSubscriptionForReady(int $storeOwnerId): SubscriptionIsReadyResponse
    {
        $subscribeId = $this->subscriptionCaptainOfferManager->isSubscriptionForReady($storeOwnerId);
        if(!$subscribeId ) {
         
            $subscribeId['subscriptionState'] = SubscriptionConstant::SUBSCRIPTION_NOT_FOUND;
         }

        else {

            $subscribeId['subscriptionState'] = SubscriptionConstant::SUBSCRIPTION_FOUND;
        }
        
         return $this->autoMapping->map("array", SubscriptionIsReadyResponse::class, $subscribeId);
    }
}
