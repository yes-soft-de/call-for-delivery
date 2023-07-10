<?php

namespace App\Service\EPayment;

use App\AutoMapping;
use App\Constant\EPaymentFromStore\EPaymentFromStoreConstant;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Notification\NotificationFirebaseConstant;
use App\Constant\Notification\NotificationTokenConstant;
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
use App\Service\Notification\NotificationFirebaseService;
use App\Service\Notification\NotificationLocalService;
use App\Service\StoreOwner\StoreOwnerProfileGetService;
use App\Service\Subscription\SubscriptionService;

class EPaymentService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private SubscriptionService $subscriptionService,
        private StoreOwnerProfileGetService $storeOwnerProfileGetService,
        private EPaymentFromStoreManager $ePaymentFromStoreManager,
        private NotificationLocalService $notificationLocalService,
        private NotificationFirebaseService $notificationFirebaseService
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

            if (($request->getPaymentGetaway() === EPaymentFromStoreConstant::PAYMENT_GETAWAY_IN_APP_PURCHASE_APPLE_CONST) ||
                ($request->getPaymentGetaway() === EPaymentFromStoreConstant::PAYMENT_GETAWAY_IN_APP_PURCHASE_GOOGLE_CONST)) {
                if (! $request->getPaymentId()) {
                    $request->setPaymentId("");
                }
            }

            if (($request->getPaymentType() === EPaymentFromStoreConstant::MOCK_PAYMENT_BY_STORE_CONST)
                || ($request->getPaymentType() === EPaymentFromStoreConstant::REAL_PAYMENT_BY_STORE_CONST)) {
                $storeOwnerProfile = $this->getStoreOwnerProfileByStoreId($request->getStoreOwnerProfile());

            } else {
                $storeOwnerProfile = $this->getStoreOwnerProfileById($request->getStoreOwnerProfile());
            }

            if (! $storeOwnerProfile) {
                return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
            }

            // if the payment for uniform package (not opening package) subscription, then update the paid flag
            //  of the last finished subscription
            if ($request->getPaymentFor() === EPaymentFromStoreConstant::PAYMENT_FOR_UNIFORM_SUBSCRIPTION_CONST) {
                $this->updateCurrentSubscriptionPaidFlagByStoreOwnerUserId($storeOwnerProfile->getStoreOwnerId(),
                    SubscriptionFlagConstant::SUBSCRIPTION_FLAG_PAID);
            }

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

                $request->setStoreOwnerProfile($storeOwnerProfile);
                $request->setSubscription($subscription);

                // create the payment if the store needs to pay in order to subscribe:
                // the store has to pay when: package is 19, or package is 18 and admin didn't approve the payment bypass
                if (($subscription->getPackage()->getId() === 19)
                    || (($subscription->getPackage()->getId() === 18) && ($storeOwnerProfile->getOpeningSubscriptionWithoutPayment() === false))) {
                    // if the payment is mock, the reset all fields to Zero
                    if (($request->getPaymentType() === EPaymentFromStoreConstant::MOCK_PAYMENT_BY_ADMIN_CONST)
                        || ($request->getPaymentType() === EPaymentFromStoreConstant::MOCK_PAYMENT_BY_STORE_CONST)
                        || ($request->getPaymentType() === EPaymentFromStoreConstant::MOCK_PAYMENT_BY_SUPER_ADMIN_CONST)) {
                        $request->setPaymentId("");
                        $request->setAmount(0.0);
                        $request->setPaymentGetaway(EPaymentFromStoreConstant::PAYMENT_GETAWAY_NOT_SPECIFIED_CONST);
                        $request->setPaymentFor(0);
                    }

                    // if the payment is done manually by admin, or if it is for testing issues, then set payment id
                    // to empty string
                    if (($request->getPaymentGetaway() === EPaymentFromStoreConstant::PAYMENT_GETAWAY_MANUAL_CONST)
                        || ($request->getPaymentGetaway() === EPaymentFromStoreConstant::PAYMENT_GETAWAY_NOT_SPECIFIED_CONST)) {
                        $request->setPaymentId("");
                    }

                    $payment = $this->ePaymentFromStoreManager->createEPaymentFromStore($request);

                    // send notifications to the store if the payment had been made by admin
                    if ($payment) {
                        if ($request->getPaymentType() === EPaymentFromStoreConstant::REAL_PAYMENT_BY_ADMIN_CONST) {
                            // local notification to store
                            $this->createLocalNotificationForStore($storeOwnerProfile->getStoreOwnerId(),
                                NotificationConstant::PAYMENT_FOR_STORE_SUBSCRIPTION_BY_ADMIN_TITLE_CONST,
                                NotificationConstant::PAYMENT_FOR_STORE_SUBSCRIPTION_BY_ADMIN_TEXT_CONST);

                            // firebase notification to store
                            $this->createFirebaseNotificationForUser($storeOwnerProfile->getStoreOwnerId(),
                                NotificationFirebaseConstant::PAYMENT_FOR_STORE_SUBSCRIPTION_BY_ADMIN_CONST);
                        }
                    }
                }

                return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $subscription);

            } else {
                return SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST;
            }
        }

        return 0;
    }

    public function createSubscriptionWithFreePackage(int $storeOwnerUserId): SubscriptionResponse|SubscriptionEntity|int|string
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

    public function createLocalNotificationForStore(int $storeOwnerUserId, string $title, string $text, int $orderId = null)
    {
        $this->notificationLocalService->createNotificationLocal($storeOwnerUserId, $title, $text,
            NotificationTokenConstant::APP_TYPE_STORE, $orderId);
    }

    public function createFirebaseNotificationForUser(int $userId, string $text)
    {
        return $this->notificationFirebaseService->notificationToUserWithoutOrderByUserId($userId, $text);
    }
}
