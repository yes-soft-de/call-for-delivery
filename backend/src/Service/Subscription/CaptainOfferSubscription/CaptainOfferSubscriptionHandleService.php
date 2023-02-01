<?php

namespace App\Service\Subscription\CaptainOfferSubscription;

use App\Constant\Subscription\SubscriptionCaptainOffer;
use App\Entity\SubscriptionCaptainOfferEntity;
use DateTime;

///TODO to be continued
/**
 * Responsible for maintaining captain offer subscription
 */
class CaptainOfferSubscriptionHandleService
{
    public function __construct()
    {
    }

    public function checkCaptainOfferSubscriptionDate(SubscriptionCaptainOfferEntity $subscriptionCaptainOfferEntity): int
    {
        $captainOfferSubscriptionEndDate = $subscriptionCaptainOfferEntity->getExpired() . 'day';

        $endDate = new DateTime($subscriptionCaptainOfferEntity->getStartDate()->format('Y-m-d h:i:s')
            . $captainOfferSubscriptionEndDate);

        if ($endDate < (new DateTime('now'))) {
            return SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_EXPIRED;
        }

        return SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_DOES_NOT_EXPIRED_CONST;
    }
}
