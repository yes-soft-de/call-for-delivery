<?php

namespace App\Service\Eraser\Subscription;

use App\AutoMapping;
use App\Constant\Subscription\SubscriptionCaptainOffer;
use App\Entity\SubscriptionCaptainOfferEntity;
use App\Entity\SubscriptionEntity;
use App\Request\Admin\Subscription\CaptainOfferSubscriptionDeleteByAdminRequest;
use App\Response\Admin\StoreOwnerSubscription\CaptainOfferSubscriptionDeleteByAdminResponse;
use App\Security\IsGranted\CaptainOfferSubscriptionGrantService;
use App\Service\Subscription\SubscriptionCaptainOfferService;
use App\Service\Subscription\SubscriptionDetailsService;
use App\Service\Subscription\SubscriptionService;

class CaptainOfferSubscriptionEraserService
{
    private AutoMapping $autoMapping;
    private CaptainOfferSubscriptionGrantService $captainOfferSubscriptionGrantService;
    private SubscriptionService $subscriptionService;
    private SubscriptionDetailsService $subscriptionDetailsService;
    private SubscriptionCaptainOfferService $subscriptionCaptainOfferService;

    public function __construct(AutoMapping $autoMapping, CaptainOfferSubscriptionGrantService $captainOfferSubscriptionGrantService, SubscriptionService $subscriptionService,
                                SubscriptionDetailsService $subscriptionDetailsService, SubscriptionCaptainOfferService $subscriptionCaptainOfferService)
    {
        $this->autoMapping = $autoMapping;
        $this->captainOfferSubscriptionGrantService = $captainOfferSubscriptionGrantService;
        $this->subscriptionService = $subscriptionService;
        $this->subscriptionDetailsService = $subscriptionDetailsService;
        $this->subscriptionCaptainOfferService = $subscriptionCaptainOfferService;
    }

    public function deleteCaptainOfferSubscriptionByAdmin(CaptainOfferSubscriptionDeleteByAdminRequest $request): string|int|CaptainOfferSubscriptionDeleteByAdminResponse
    {
        try {
            // first check if can delete captain offer subscription
            $grantResult = $this->captainOfferSubscriptionGrantService->canDeleteCaptainOfferSubscription($request);//dd($grantResult);

            if ($grantResult[0] !== SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_CAN_BE_DELETED) {
                return $grantResult[1];
            }

            // While we reach here, captain offer can be deleted
            $subscriptionCaptainOfferResult = [];

            // But deleting procedure depends on if the subscription is future or current
            if ($grantResult[1] === SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_CURRENT) {

                // 1 - Update related record in SubscriptionEntity
                // A - Update remaining cars field
                $remainingCars = $grantResult[2]->getRemainingCars() -
                    $grantResult[2]->getLastSubscription()->getSubscriptionCaptainOffer()->getCarCount();

                $subscriptionDetailsUpdateResult = $this->subscriptionDetailsService->updateRemainingCars($grantResult[2]->getLastSubscription()->getId(), $remainingCars);

                if ($subscriptionDetailsUpdateResult) {
                    $subscriptionCaptainOfferResult = $this->deleteCaptainOfferSubscription($grantResult[2]->getLastSubscription());
                }

            } elseif ($grantResult[1] === SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_FUTURE) {
                $subscriptionCaptainOfferResult = $this->deleteCaptainOfferSubscription($grantResult[2]->getLastSubscription());
            }

            if (! $subscriptionCaptainOfferResult) {
                return SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_DELETE_PROBLEM;
            }

            return $this->autoMapping->map(SubscriptionCaptainOfferEntity::class, CaptainOfferSubscriptionDeleteByAdminResponse::class, $subscriptionCaptainOfferResult);

        } catch (\Exception $exception) {
            error_log($exception);
        }

        return SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_DELETE_PROBLEM;
    }

    public function deleteCaptainOfferSubscription(SubscriptionEntity $subscriptionEntity): ?SubscriptionCaptainOfferEntity
    {
        // just save captain offer subscription id for later operation
        $subscriptionCaptainOfferId = $subscriptionEntity->getSubscriptionCaptainOffer()->getId();

        // A - Update other related fields in SubscriptionEntity:
        $subscriptionUpdateResult = $this->subscriptionService->updateSubscriptionByRemovingCaptainOfferSubscription($subscriptionEntity->getId());

        // B - Delete captain offer subscription record
        if (! $subscriptionUpdateResult) {
            return $subscriptionUpdateResult;
        }

        return $this->subscriptionCaptainOfferService->deleteCaptainOfferSubscriptionById($subscriptionCaptainOfferId);
    }
}
