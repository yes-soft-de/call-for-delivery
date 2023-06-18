<?php

namespace App\Service\EPayment;

use App\AutoMapping;
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

    public function createEPaymentByStoreOwner(EPaymentCreateByStoreOwnerRequest $request): SubscriptionResponse|int|string
    {
        if ($request->getStatus() === 1) {
            // update the flag field of the last finished subscription to isPaid
            $subscriptionFlagUpdateResult = $this->updateCurrentSubscriptionPaidFlagByStoreOwnerUserId($request->getStoreOwnerProfile(),
                SubscriptionFlagConstant::SUBSCRIPTION_FLAG_PAID);

            // create new subscription
            $subscription = $this->subscriptionService->createSubscriptionWithFreePackage($request->getStoreOwnerProfile());

            if (($subscription === PackageConstant::PACKAGE_NOT_EXIST)
                || ($subscription === SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST)) {
                return $subscription;
            }

            // create the payment
            $storeOwnerProfile = $this->getStoreOwnerProfileByStoreId($request->getStoreOwnerProfile());

            if (! $storeOwnerProfile) {
                return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
            }

            $request->setStoreOwnerProfile($storeOwnerProfile);
            $request->setSubscription($subscription);

            $this->ePaymentFromStoreManager->createEPaymentFromStore($request);

            return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $subscription);
            //return $subscription;
        }

        return 0;
    }
}
