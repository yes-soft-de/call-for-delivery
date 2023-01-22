<?php

namespace App\Service\Subscription;

use App\Constant\Subscription\SubscriptionConstant;
use App\Constant\Subscription\SubscriptionDetailsConstant;
use App\Entity\SubscriptionDetailsEntity;
use App\Entity\SubscriptionEntity;
use App\Manager\Subscription\SubscriptionManager;
use DateTime;
use DateTimeInterface;

////TODO to be continued
/**
 * This service responsible for maintaining the store subscription, and it will be continued later
 */
class StoreSubscriptionHandleService
{
    private SubscriptionManager $subscriptionManager;

    public function __construct(SubscriptionManager $subscriptionManager)
    {
        $this->subscriptionManager = $subscriptionManager;
    }

    // Check store subscription (status, date, orders, and cars)
    public function checkStoreSubscriptionValidationBySubscriptionDetailsEntity(SubscriptionDetailsEntity $subscriptionDetails)
    {
        if (! $subscriptionDetails) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        // Currently there is no feature of activating/deactivating the subscription of a store,
        // so this state will not be reached
        if ($subscriptionDetails->getStatus() === SubscriptionConstant::SUBSCRIBE_INACTIVE) {
            return SubscriptionConstant::SUBSCRIBE_INACTIVE;
        }

        // 1. Check subscription date
        $checkDateResult = $this->checkSubscriptionDateBySubscriptionStartAndEndDatesAndHasExtra(
            $subscriptionDetails->getLastSubscription()->getStartDate(), $subscriptionDetails->getLastSubscription()->getEndDate(),
            $subscriptionDetails->getHasExtra());

        if ($checkDateResult === SubscriptionConstant::DATE_FINISHED) {
            return SubscriptionConstant::DATE_FINISHED;
        }

        // 2. Check subscription orders
        $checkRemainingOrdersResult = $this->checkRemainingOrdersBySubscriptionRemainingOrdersAndPackageOrdersCount($subscriptionDetails->getRemainingOrders(),
            $subscriptionDetails->getLastSubscription()->getPackage()->getOrderCount());

        if (($checkRemainingOrdersResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_BIGGER_THAN_PACKAGE_ORDERS_CONST)
            || ($checkRemainingOrdersResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_FINISHED)
            || ($checkRemainingOrdersResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_LESS_THAN_ZERO_CONST)) {
            return $checkRemainingOrdersResult;
        }

        // 3. Check subscription cars
        $checkRemainingCarsResult = $this->checkRemainingCarsBySubscriptionRemainingCarsAndPackageCarsCount($subscriptionDetails->getRemainingCars(),
            $subscriptionDetails->getLastSubscription()->getPackage()->getCarCount());

        if (($checkRemainingCarsResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_CARS_IS_BIGGER_THAN_PACKAGE_CARS_CONST)
            || ($checkRemainingCarsResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_CARS_IS_FINISHED)
            || ($checkRemainingCarsResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_CARS_IS_LESS_THAN_ZERO_CONST)) {
            return $checkRemainingCarsResult;
        }

        return $subscriptionDetails;
    }

    public function checkSubscriptionDateBySubscriptionStartAndEndDatesAndHasExtra(DateTimeInterface $subscriptionStartDate, DateTimeInterface $subscriptionEndDate, bool $hasExtra): string
    {
        $dateNow = new DateTime('now');

        if ($hasExtra === SubscriptionConstant::IS_HAS_EXTRA_TRUE) {
            $subscriptionEndDate = new DateTime($subscriptionStartDate->format('Y-m-d h:i:s') . '1 day');
        }

        // check if the subscription has expired
        if ($subscriptionEndDate < $dateNow ) {
            return SubscriptionConstant::DATE_FINISHED;
        }

        return SubscriptionConstant::SUBSCRIPTION_DATE_IS_VALID_CONST;
    }

    public function checkRemainingCarsBySubscriptionRemainingCarsAndPackageCarsCount(int $subscriptionRemainingCars, int $packageCarsCount): int|string
    {
        if ($subscriptionRemainingCars > $packageCarsCount) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_CARS_IS_BIGGER_THAN_PACKAGE_CARS_CONST;

        } elseif ($subscriptionRemainingCars === $packageCarsCount) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_CARS_IS_EQUAL_TO_PACKAGE_CARS_COUNT_CONST;

        } else {
            //$subscriptionRemainingOrders < $packageOrdersCount
            if ($subscriptionRemainingCars === 0) {
                return SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_CARS_IS_FINISHED;

            } elseif ($subscriptionRemainingCars < 0) {
                return SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_CARS_IS_LESS_THAN_ZERO_CONST;
            }

            return SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_CARS_IS_VALID_CONST;
        }
    }

    public function checkRemainingOrdersBySubscriptionRemainingOrdersAndPackageOrdersCount(int $subscriptionRemainingOrders, int $packageOrdersCount): int
    {
        if ($subscriptionRemainingOrders > $packageOrdersCount) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_BIGGER_THAN_PACKAGE_ORDERS_CONST;

        } elseif ($subscriptionRemainingOrders === $packageOrdersCount) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_EQUAL_TO_PACKAGE_ORDER_COUNT_CONST;

        } else {
            //$subscriptionRemainingOrders < $packageOrdersCount
            if ($subscriptionRemainingOrders === 0) {
                return SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_FINISHED;

            } elseif ($subscriptionRemainingOrders < 0) {
                return SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_LESS_THAN_ZERO_CONST;
            }

            return SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_VALID_CONST;
        }
    }

    public function getFutureSubscriptionByStoreOwnerProfileId(int $storeOwnerProfileId): array|int
    {
        $futureSubscription = $this->subscriptionManager->getFutureSubscriptionByStoreOwnerProfileId($storeOwnerProfileId);

        if (count($futureSubscription) === 0) {
            return SubscriptionConstant::FUTURE_SUBSCRIPTION_DOES_NOT_EXIST_CONST;
        }

        return $futureSubscription;
    }

    public function checkCurrentSubscriptionDateAndRemainingOrders(
        DateTimeInterface $subscriptionStartDate,
        DateTimeInterface $subscriptionEndDate,
        bool $hasExtra,
        int $subscriptionRemainingOrders,
        int $packageOrdersCount): int
    {
        $checkDateResult = $this->checkSubscriptionDateBySubscriptionStartAndEndDatesAndHasExtra($subscriptionStartDate,
            $subscriptionEndDate, $hasExtra);

        if ($checkDateResult === SubscriptionConstant::DATE_FINISHED) {
            return SubscriptionConstant::SUBSCRIPTION_DATE_IS_FINISHED_CONST;
        }

        // continue checking orders
        $checkOrdersResult = $this->checkRemainingOrdersBySubscriptionRemainingOrdersAndPackageOrdersCount($subscriptionRemainingOrders, $packageOrdersCount);

        if (($checkOrdersResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_BIGGER_THAN_PACKAGE_ORDERS_CONST)
            || ($checkOrdersResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_FINISHED)
            || ($checkOrdersResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_LESS_THAN_ZERO_CONST)) {
            return $checkOrdersResult;
        }

        return SubscriptionConstant::SUBSCRIPTION_REMAINING_ORDERS_AND_DATE_ARE_VALID_CONST;
    }

    ///TODO to be continued
    public function checkCurrentSubscriptionSituationAndUpdateIt(SubscriptionDetailsEntity $subscriptionDetails)
    {
        $checkSubscriptionResult = $this->checkStoreSubscriptionValidationBySubscriptionDetailsEntity($subscriptionDetails);

        if ($checkSubscriptionResult === SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;

        } elseif (($checkSubscriptionResult === SubscriptionConstant::DATE_FINISHED)
            || ($checkSubscriptionResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_FINISHED)) {
            // may be move to the next subscription (future) (if exists)
            $updateSubscriptionResult = $this->checkIfThereIsFutureSubscriptionAndSetItAsCurrentSubscription($checkSubscriptionResult->getStoreOwner()->getId());

        } elseif ($checkSubscriptionResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_BIGGER_THAN_PACKAGE_ORDERS_CONST) {
            // as a initial solution, set the subscription as an active one

        } elseif ($checkSubscriptionResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_LESS_THAN_ZERO_CONST) {
            // as an initial solution, set the status of the subscription to 'order finished'

        } elseif ($checkSubscriptionResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_CARS_IS_FINISHED) {
            // check if there is an active and not used captain offer subscription
            // No captain offer exist -> set subscription status to 'cars finished'
            // Captain offer exists, but used -> set subscription status to 'cars finished'
            // Captain offer exists and it wasn't used yet, update the remaining cars

        } elseif ($checkSubscriptionResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_CARS_IS_BIGGER_THAN_PACKAGE_CARS_CONST) {

        } elseif ($checkSubscriptionResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_CARS_IS_LESS_THAN_ZERO_CONST) {
            // check if there is an active and not used captain offer subscription

        } else {
            // subscription date, orders, and cars are all ok and not finished yet
            // update the subscription state to 'active'
        }

        //elseif ($checkSubscriptionResult === SubscriptionConstant::SUBSCRIBE_INACTIVE) {
        //    // Currently there is no feature of activating/deactivating the subscription of a store,
        //    // so this state will not be reached
        //}
    }

    public function updateFutureSubscriptionToCurrentSubscription(int $futureSubscriptionId): SubscriptionEntity|int
    {
        return $this->subscriptionManager->updateFutureSubscriptionToCurrentSubscription($futureSubscriptionId);
    }

    public function checkIfThereIsFutureSubscriptionAndSetItAsCurrentSubscription(int $storeOwnerProfileId): SubscriptionEntity|int
    {
        $futureSubscription = $this->getFutureSubscriptionByStoreOwnerProfileId($storeOwnerProfileId);

        if ($futureSubscription === SubscriptionConstant::FUTURE_SUBSCRIPTION_DOES_NOT_EXIST_CONST) {
            return SubscriptionConstant::FUTURE_SUBSCRIPTION_DOES_NOT_EXIST_CONST;
        }

        return $this->updateFutureSubscriptionToCurrentSubscription($futureSubscription[0]->getId());
    }
}
