<?php

namespace App\Service\Admin\StoreOwnerSubscription;

use App\AutoMapping;
use App\Constant\CaptainOfferConstant\CaptainOfferConstant;
use App\Constant\Notification\SubscriptionFirebaseNotificationConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\Subscription\SubscriptionCaptainOffer;
use App\Constant\Subscription\SubscriptionConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionCaptainOfferEntity;
use App\Manager\Admin\StoreOwnerSubscription\AdminCaptainOfferSubscriptionManager;
use App\Request\Admin\Subscription\AdminCaptainOfferSubscriptionCreateRequest;
use App\Request\Admin\Subscription\CaptainOfferSubscriptionDeleteByAdminRequest;
use App\Response\Admin\StoreOwnerSubscription\AdminCaptainOfferSubscriptionCreateResponse;
use App\Response\Admin\StoreOwnerSubscription\CaptainOfferSubscriptionDeleteByAdminResponse;
use App\Response\Admin\StoreOwnerSubscription\SubscriptionStateGetForAdminResponse;
use App\Service\Admin\CaptainOffer\AdminCaptainOfferService;
use App\Service\Admin\StoreOwner\AdminStoreOwnerService;
use App\Service\Eraser\Subscription\CaptainOfferSubscriptionEraserService;
use App\Service\Notification\CaptainOfferSubscriptionFirebaseNotificationService;

class AdminCaptainOfferSubscriptionService
{
    private AutoMapping $autoMapping;
    private AdminStoreOwnerService $adminStoreOwnerService;
    private AdminCaptainOfferService $adminCaptainOfferService;
    private CaptainOfferSubscriptionEraserService $captainOfferSubscriptionEraserService;
    private CaptainOfferSubscriptionFirebaseNotificationService $captainOfferSubscriptionFirebaseNotificationService;
    private AdminCaptainOfferSubscriptionManager $adminCaptainOfferSubscriptionManager;

    public function __construct(AutoMapping $autoMapping, AdminStoreOwnerService $adminStoreOwnerService, AdminCaptainOfferService $adminCaptainOfferService,
                                CaptainOfferSubscriptionEraserService $captainOfferSubscriptionEraserService, AdminCaptainOfferSubscriptionManager $adminCaptainOfferSubscriptionManager,
                                CaptainOfferSubscriptionFirebaseNotificationService $captainOfferSubscriptionFirebaseNotificationService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminStoreOwnerService = $adminStoreOwnerService;
        $this->adminCaptainOfferService = $adminCaptainOfferService;
        $this->captainOfferSubscriptionEraserService = $captainOfferSubscriptionEraserService;
        $this->captainOfferSubscriptionFirebaseNotificationService = $captainOfferSubscriptionFirebaseNotificationService;
        $this->adminCaptainOfferSubscriptionManager = $adminCaptainOfferSubscriptionManager;
    }

    public function createCaptainOfferSubscriptionByAdmin(AdminCaptainOfferSubscriptionCreateRequest $request): string|AdminCaptainOfferSubscriptionCreateResponse|SubscriptionStateGetForAdminResponse
    {
        // get store owner profile entity
        $storeOwnerProfileEntity = $this->adminStoreOwnerService->getStoreOwnerProfileEntityByStoreOwnerId($request->getStoreOwner());

        if (! $storeOwnerProfileEntity) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        $request->setStoreOwner($storeOwnerProfileEntity);

        // get captain offer entity
        $captainOfferEntity = $this->adminCaptainOfferService->getCaptainOfferEntityByIdForAdmin($request->getCaptainOffer());

        if (! $captainOfferEntity) {
            return CaptainOfferConstant::CAPTAIN_OFFER_NOT_EXIST;
        }

        $request->setCaptainOffer($captainOfferEntity);

        // check if we can create a subscription with the captain offer
        $canCreateCaptainOfferSubscription = $this->isThereSubscription($storeOwnerProfileEntity);

        if ($canCreateCaptainOfferSubscription->subscriptionState === SubscriptionConstant::SUBSCRIPTION_NOT_FOUND ||
            $canCreateCaptainOfferSubscription->subscriptionState === SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_CAN_NOT_SUBSCRIPTION) {

            return $canCreateCaptainOfferSubscription;
        }

        // while we here, we can now create the required subscription
        $arrayResult = $this->adminCaptainOfferSubscriptionManager->createCaptainOfferSubscriptionByAdmin($request);

        // Check if remaining cars had negative value, and inform admin if it has
        if ($arrayResult[1] !== SubscriptionConstant::ERROR) {
            $subscriptionDetailsResult = $arrayResult[1][1];

            if ($subscriptionDetailsResult) {
                $this->checkRemainingCarsOfStoreSubscriptionAndInformAdmin($subscriptionDetailsResult->getRemainingCars(),
                    $subscriptionDetailsResult->getStoreOwner()->getStoreOwnerName());
            }
        }

        return $this->autoMapping->map(SubscriptionCaptainOfferEntity::class, AdminCaptainOfferSubscriptionCreateResponse::class, $arrayResult[0]);
    }

    public function isThereSubscription(StoreOwnerProfileEntity $storeOwnerProfileId): SubscriptionStateGetForAdminResponse
    {
        $subscription = $this->adminCaptainOfferSubscriptionManager->isThereSubscription($storeOwnerProfileId);

        if ($subscription === null) {
            $subscription['subscriptionState'] = SubscriptionConstant::SUBSCRIPTION_NOT_FOUND;

        } else {
            $subscriptionCaptainOffer = $this->adminCaptainOfferSubscriptionManager->getSubscriptionCaptainOfferBySubscriptionId($subscription['lastSubscription']);

            if ($subscriptionCaptainOffer) {
                if ($subscriptionCaptainOffer['status'] === SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_ACTIVE) {
                    $subscription['subscriptionState'] = SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_CAN_NOT_SUBSCRIPTION;
                }
            }
        }

        return $this->autoMapping->map("array", SubscriptionStateGetForAdminResponse::class, $subscription);
    }

    public function deleteCaptainOfferSubscriptionByAdmin(CaptainOfferSubscriptionDeleteByAdminRequest $request): string|int|CaptainOfferSubscriptionDeleteByAdminResponse
    {
        return $this->captainOfferSubscriptionEraserService->deleteCaptainOfferSubscriptionByAdmin($request);
    }

    public function sendFirebaseNotificationToAdmin(string $notificationDescription, string $storeOwnerName): array
    {
        return $this->captainOfferSubscriptionFirebaseNotificationService->sendFirebaseNotificationToAdmin($notificationDescription,
            $storeOwnerName);
    }

    public function checkRemainingCarsOfStoreSubscriptionAndInformAdmin(int $remainingCars, string $storeOwnerName)
    {
        if ($remainingCars < 0) {
            // Notify admin by firebase notification
            $this->sendFirebaseNotificationToAdmin(SubscriptionFirebaseNotificationConstant::STORE_SUBSCRIPTION_REMAINING_CARS_NEGATIVE_VALUE_CONST,
                $storeOwnerName);
        }
    }
}
