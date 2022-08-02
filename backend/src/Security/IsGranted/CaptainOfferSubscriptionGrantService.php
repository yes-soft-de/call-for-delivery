<?php

namespace App\Security\IsGranted;

use App\Constant\Subscription\SubscriptionCaptainOffer;
use App\Constant\Subscription\SubscriptionConstant;
use App\Entity\SubscriptionCaptainOfferEntity;
use App\Entity\SubscriptionDetailsEntity;
use App\Request\Admin\Subscription\CaptainOfferSubscriptionDeleteByAdminRequest;
use App\Service\DateFactory\DateFactoryService;
use App\Service\Order\OrderService;
use App\Service\Subscription\SubscriptionDetailsService;
use App\Service\Subscription\SubscriptionService;

class CaptainOfferSubscriptionGrantService
{
    private SubscriptionService $subscriptionService;
    private SubscriptionDetailsService $subscriptionDetailsService;
    private DateFactoryService $dateFactoryService;
    private OrderService $orderService;

    public function __construct(SubscriptionService $subscriptionService, SubscriptionDetailsService $subscriptionDetailsService, DateFactoryService $dateFactoryService,
                                OrderService $orderService)
    {
        $this->subscriptionService = $subscriptionService;
        $this->subscriptionDetailsService = $subscriptionDetailsService;
        $this->dateFactoryService = $dateFactoryService;
        $this->orderService = $orderService;
    }

    public function canDeleteCaptainOfferSubscription(CaptainOfferSubscriptionDeleteByAdminRequest $request): array
    {
        // 1 - Check if subscription is current or not
        $subscriptionDetailsArrayResult = $this->subscriptionDetailsService->getSubscriptionDetailsEntityByLastSubscriptionId($request->getStoreSubscriptionId());

        if (count($subscriptionDetailsArrayResult) > 0) {
            // The store subscription is a current one
            // A - Check if captain offer subscription is exist
            if ($subscriptionDetailsArrayResult[0]->getLastSubscription()->getSubscriptionCaptainOffer()) {
                // B - Check if captain offer subscription status is Active
                if ($subscriptionDetailsArrayResult[0]->getLastSubscription()->getSubscriptionCaptainOffer()->getStatus() === SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_INACTIVE) {
                    // captain offer subscription status is not Active, we can not delete captain offer
                    return [SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_CAN_NOT_BE_DELETED,
                        SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_INACTIVE];
                }

                // C - Check expiration date of the captain offer subscription
                // compare (start date + expire) with current date
                if ($this->checkIfCaptainOfferSubscriptionIsExpired($subscriptionDetailsArrayResult[0]->getLastSubscription()->getSubscriptionCaptainOffer()) === true) {
                    return [SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_CAN_NOT_BE_DELETED,
                        SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_EXPIRED];
                }

                // D - Check if we want to delete the captain offer subscription even if it is being used or not.
                if ($request->getDeleteEvenItIsBeingUsed() === 0) {
                    // E - Check if captain offer is consumed
                    if ($this->checkIfCaptainOfferCarsConsumed($subscriptionDetailsArrayResult[0]) === true) {
                        return [SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_CAN_NOT_BE_DELETED,
                            SubscriptionCaptainOffer::CAPTAIN_OFFER_CARS_HAVE_BEING_USED];
                    }
                }

                // Safe to delete captain offer subscription
                return [SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_CAN_BE_DELETED,
                    SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_CURRENT, $subscriptionDetailsArrayResult[0]];
            }

            // Captain offer subscription is not exist
            return [SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_CAN_NOT_BE_DELETED,
                SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_NOT_EXIST];
        }

        // 2 - Store subscription is not a current one, may be old or future one
        $subscriptionEntity = $this->subscriptionService->getSubscriptionEntityById($request->getStoreSubscriptionId());

        // A - Check if there is a subscription
        if (! $subscriptionEntity) {
            return [SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_CAN_NOT_BE_DELETED,
                SubscriptionConstant::SUBSCRIPTION_NOT_FOUND];

        } else {
            // B - check if subscription is a future or an old one
            if ($subscriptionEntity->getIsFuture() === true) {
                // store subscription is a future one, so we cam remove captain offer subscription
                return [SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_CAN_BE_DELETED,
                    SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_FUTURE, $subscriptionEntity];
            }

            // store subscription is an old one, we can not remove captain offer subscription
            return [SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_CAN_NOT_BE_DELETED,
                SubscriptionConstant::OLD_STORE_SUBSCRIPTION];
        }
    }

    public function checkIfCaptainOfferSubscriptionIsExpired(SubscriptionCaptainOfferEntity $subscriptionCaptainOfferEntity): bool
    {
        $expirationDate = $this->dateFactoryService->sumDaysWithDateTimeInterface($subscriptionCaptainOfferEntity->getStartDate(), $subscriptionCaptainOfferEntity->getExpired());

        return (new \DateTime('now') > $expirationDate);
    }

    public function checkIfCaptainOfferCarsConsumed(SubscriptionDetailsEntity $subscriptionDetailsEntity): bool
    {
        /**
         * captain offer cars are consumed when:
         * specific orders count > store subscription cars
         * specific orders: meet the conditions:
         *   unique captains (we do not need to count all orders that being taken by the same captain)
         * + (created order log of 'on way to pick order' > start date captain offer subscription)
         */
        $ordersCountArrayResult = $this->orderService->getStoreOrdersWhichTakenByUniqueCaptainsAfterSpecificDate($subscriptionDetailsEntity->getStoreOwner(),
            $subscriptionDetailsEntity->getLastSubscription()->getSubscriptionCaptainOffer()->getStartDate());

        if (count($ordersCountArrayResult) > 0) {
            if (array_sum($ordersCountArrayResult) > $subscriptionDetailsEntity->getLastSubscription()->getPackage()->getCarCount()) {
                // captain offer cars consumed
                return true;
            }
        }

        return false;
    }
}
