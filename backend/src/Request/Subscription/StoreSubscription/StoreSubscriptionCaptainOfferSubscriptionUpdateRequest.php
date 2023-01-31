<?php

namespace App\Request\Subscription\StoreSubscription;

use App\Entity\SubscriptionCaptainOfferEntity;

/**
 * For updating captain offer subscription of a specific store subscription
 */
class StoreSubscriptionCaptainOfferSubscriptionUpdateRequest
{
    private int $id;

    private SubscriptionCaptainOfferEntity $subscriptionCaptainOfferEntity;

    /**
     * @var bool|null
     */
    private $captainOfferFirstTime;

    public function getId(): int
    {
        return $this->id;
    }

    public function setId(int $id): void
    {
        $this->id = $id;
    }

    public function getSubscriptionCaptainOfferEntity(): SubscriptionCaptainOfferEntity
    {
        return $this->subscriptionCaptainOfferEntity;
    }

    public function setSubscriptionCaptainOfferEntity(SubscriptionCaptainOfferEntity $subscriptionCaptainOfferEntity): void
    {
        $this->subscriptionCaptainOfferEntity = $subscriptionCaptainOfferEntity;
    }

    public function getCaptainOfferFirstTime(): ?bool
    {
        return $this->captainOfferFirstTime;
    }

    public function setCaptainOfferFirstTime(?bool $captainOfferFirstTime): void
    {
        $this->captainOfferFirstTime = $captainOfferFirstTime;
    }
}
