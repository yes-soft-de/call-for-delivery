<?php

namespace App\Service\EPayment;

use App\AutoMapping;
use App\Constant\EPaymentFromStore\EPaymentFromStoreConstant;
use App\Constant\Package\PackageConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\Subscription\SubscriptionConstant;
use App\Constant\Subscription\SubscriptionDetailsConstant;
use App\Constant\Subscription\SubscriptionFlagConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionDetailsEntity;
use App\Entity\SubscriptionEntity;
use App\Manager\EPaymentFromStore\EPaymentFromStoreManager;
use App\Request\EPayment\EPaymentCreateByStoreOwnerRequest;
use App\Request\Subscription\SubscriptionCreateRequest;
use App\Response\Subscription\SubscriptionErrorResponse;
use App\Response\Subscription\SubscriptionResponse;
use App\Service\StoreOwner\StoreOwnerProfileGetService;
use App\Service\Subscription\SubscriptionService;

class EPaymentService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private SubscriptionService $subscriptionService,
        private StoreOwnerProfileGetService $storeOwnerProfileGetService,
        private EPaymentFromStoreManager $ePaymentFromStoreManager
    )
    {
    }

    public function updateCurrentSubscriptionPaidFlagByStoreOwnerUserId(int $storeOwnerUserId, int $paidFlag): SubscriptionEntity|string
    {
        return $this->subscriptionService->updateCurrentSubscriptionPaidFlagByStoreOwnerUserId($storeOwnerUserId, $paidFlag);
    }

    public function getStoreOwnerProfileByStoreId($storeOwnerId): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileGetService->getStoreOwnerProfileByStoreId($storeOwnerId);
    }

    private function getStoreOwnerProfileById(int $getStoreOwnerProfile): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileGetService->getStoreOwnerProfileById($getStoreOwnerProfile);
    }

    public function createEPaymentByStoreOwner(EPaymentCreateByStoreOwnerRequest $request): SubscriptionResponse|int|string|SubscriptionErrorResponse
    {
        if ($request->getStatus() === 1) {
            // update the flag field of the last finished subscription to isPaid

            if (($request->getPaymentType() === EPaymentFromStoreConstant::MOCK_PAYMENT_BY_STORE_CONST)
                || ($request->getPaymentType() === EPaymentFromStoreConstant::REAL_PAYMENT_BY_STORE_CONST)) {
                $storeOwnerProfile = $this->getStoreOwnerProfileByStoreId($request->getStoreOwnerProfile());

            } else {
                $storeOwnerProfile = $this->getStoreOwnerProfileById($request->getStoreOwnerProfile());
            }

            if (! $storeOwnerProfile) {
                return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
            }

            $subscriptionFlagUpdateResult = $this->updateCurrentSubscriptionPaidFlagByStoreOwnerUserId($storeOwnerProfile->getStoreOwnerId(),
                SubscriptionFlagConstant::SUBSCRIPTION_FLAG_PAID);

            // create new subscription
            if ($request->getPaymentFor() === EPaymentFromStoreConstant::PAYMENT_FOR_SUBSCRIPTION_CONST) {
                $subscription = $this->createSubscriptionWithFreePackage($storeOwnerProfile->getStoreOwnerId());

            } elseif ($request->getPaymentFor() === EPaymentFromStoreConstant::PAYMENT_FOR_UNIFORM_SUBSCRIPTION_CONST) {
                $subscription = $this->createSubscription($storeOwnerProfile->getStoreOwnerId(), 19);
            }

            if ($subscription) {
                if (($subscription === SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND)
                    || ($subscription instanceof SubscriptionErrorResponse)
                    || ($subscription === PackageConstant::PACKAGE_NOT_EXIST)
                    || ($subscription === SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST)) {
                    return $subscription;
                }

                // create the payment if the store needs to pay to subscribe
                if ($storeOwnerProfile->getOpeningSubscriptionWithoutPayment() === false) {
                    $request->setStoreOwnerProfile($storeOwnerProfile);
                    $request->setSubscription($subscription);

                    if (($request->getPaymentType() === EPaymentFromStoreConstant::MOCK_PAYMENT_BY_ADMIN_CONST)
                        || ($request->getPaymentType() === EPaymentFromStoreConstant::MOCK_PAYMENT_BY_STORE_CONST)
                        || ($request->getPaymentType() === EPaymentFromStoreConstant::MOCK_PAYMENT_BY_SUPER_ADMIN_CONST)) {
                        $request->setPaymentId("");
                        $request->setAmount(0.0);
                        $request->setPaymentGetaway(0);
                        $request->setPaymentFor(0);
                    }

                    $payment = $this->ePaymentFromStoreManager->createEPaymentFromStore($request);
                }

                return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $subscription);
            }

            return SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST;
        }

        return 0;
    }

    public function createSubscriptionWithFreePackage(int $storeOwnerUserId)
    {
        return $this->subscriptionService->createSubscriptionWithFreePackage($storeOwnerUserId);
    }

    public function getSubscriptionDetailsEntityByStoreOwnerUserId(int $storeOwnerId): ?SubscriptionDetailsEntity
    {
        return $this->subscriptionService->getSubscriptionDetailsEntityByStoreOwnerUserId($storeOwnerId);
    }

    public function createSubscription(int $storeOwnerUserId, int $packageId): SubscriptionEntity|SubscriptionErrorResponse|int
    {
        $request = new SubscriptionCreateRequest();

        $request->setStoreOwner($storeOwnerUserId);
        $request->setPackage($packageId);

        $subscription = $this->subscriptionService->createSubscription($request);

        if ($subscription instanceof SubscriptionErrorResponse) {
            return $subscription;
        }

        $currentSubscriptionDetails = $this->getSubscriptionDetailsEntityByStoreOwnerUserId($storeOwnerUserId);

        if ($currentSubscriptionDetails) {
            return $currentSubscriptionDetails->getLastSubscription();
        }

        return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
    }
}
