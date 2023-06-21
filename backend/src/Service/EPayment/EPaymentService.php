<?php

namespace App\Service\EPayment;

use App\AutoMapping;
use App\Constant\EPaymentFromStore\EPaymentFromStoreConstant;
use App\Constant\Package\PackageConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\Subscription\SubscriptionConstant;
use App\Constant\Subscription\SubscriptionFlagConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionEntity;
use App\Manager\EPaymentFromStore\EPaymentFromStoreManager;
use App\Request\EPayment\EPaymentCreateByStoreOwnerRequest;
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

    public function createEPaymentByStoreOwner(EPaymentCreateByStoreOwnerRequest $request): SubscriptionResponse|int|string
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
            $subscription = $this->subscriptionService->createSubscriptionWithFreePackage($storeOwnerProfile->getStoreOwnerId());

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

                $this->ePaymentFromStoreManager->createEPaymentFromStore($request);
            }

            return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $subscription);
        }

        return 0;
    }
}
