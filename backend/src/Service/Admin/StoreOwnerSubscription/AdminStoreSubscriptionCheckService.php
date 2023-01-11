<?php

namespace App\Service\Admin\StoreOwnerSubscription;

use App\Constant\Order\OrderResultConstant;
use App\Constant\Subscription\SubscriptionConstant;
use App\Service\DateFactory\DateFactoryService;
use DateTimeInterface;

// This service for only check specific operation related to store subscription
class AdminStoreSubscriptionCheckService
{
    private DateFactoryService $dateFactoryService;

    public function __construct(DateFactoryService $dateFactoryService)
    {
        $this->dateFactoryService = $dateFactoryService;
    }

    // Note: subtrahend is the quantity that we want to subtract from the remaining cars
    public function checkIfUpdateRemainingCarsAllowed(string $operationType, int $remainingCars, int $subtrahend): bool
    {
        if ($operationType === SubscriptionConstant::OPERATION_TYPE_SUBTRACTION) {
            if ($remainingCars <= 0) {
                return false;

            } else {
                // remaining cars > 0
                // check if we do the subtraction the result is equal or bigger than zero
                if (($remainingCars - $subtrahend) < 0) {
                    return false;

                } elseif (($remainingCars - $subtrahend) >= 0) {
                    return true;
                }
            }
        }

        return true;
    }

    // Note: subtrahend is the quantity that we want to subtract from the remaining orders
    public function checkIfUpdateRemainingOrdersAllowed(string $operationType, int $remainingOrders, int $subtrahend): bool
    {
        if ($operationType === SubscriptionConstant::OPERATION_TYPE_SUBTRACTION) {
            if ($remainingOrders <= 0) {
                return false;

            } else {
                // remaining cars > 0
                // check if we do the subtraction the result is equal or bigger than zero
                if (($remainingOrders - $subtrahend) < 0) {
                    return false;

                } elseif (($remainingOrders - $subtrahend) >= 0) {
                    return true;
                }
            }
        }

        return true;
    }

    public function checkIfOrderBelongToStoreSubscriptionByOrderCreationDateAndSubscriptionValidationDate(DateTimeInterface $orderCreatedAt, DateTimeInterface $subscriptionStartDate, DateTimeInterface $subscriptionEndDate): bool
    {
        if (! $this->dateFactoryService->checkIfDateTimeInterfaceIsBetweenTwoDateTime($orderCreatedAt, $subscriptionStartDate,
            $subscriptionEndDate)) {
            return false;
        }

        return true;
    }
}
