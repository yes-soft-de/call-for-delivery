<?php

namespace App\Service\Subscription;

use App\AutoMapping;
use App\Constant\CaptainOffer\CaptainOfferConstant;
use App\Entity\SubscriptionCaptainOfferEntity;
use App\Manager\Subscription\SubscriptionCaptainOfferManager;
use App\Request\Subscription\SubscriptionCaptainOfferCreateRequest;
use App\Response\Subscription\SubscriptionCaptainOfferCreateResponse;

class SubscriptionCaptainOfferService
{
    private AutoMapping $autoMapping;
    private SubscriptionCaptainOfferManager $subscriptionCaptainOfferManager;

    public function __construct(AutoMapping $autoMapping, SubscriptionCaptainOfferManager $subscriptionCaptainOfferManager)
    {
        $this->autoMapping = $autoMapping;
        $this->subscriptionCaptainOfferManager = $subscriptionCaptainOfferManager;
    }

    public function createSubscriptionCaptainOffer(SubscriptionCaptainOfferCreateRequest $request): SubscriptionCaptainOfferCreateResponse
    {
        $captainOffer = $this->subscriptionCaptainOfferManager->createSubscriptionCaptainOffer($request);

        return $this->autoMapping->map(SubscriptionCaptainOfferEntity::class, SubscriptionCaptainOfferCreateResponse::class, $captainOffer);
    }

    public function updateState(int $id, string $status): ?SubscriptionCaptainOfferEntity
    {
        return $this->subscriptionCaptainOfferManager->updateState($id, $status);
    }
}
