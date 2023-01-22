<?php

namespace App\Service\Subscription;

use App\Constant\Order\OrderResultConstant;
use App\Constant\Subscription\SubscriptionConstant;
use App\Service\DateFactory\DateFactoryService;
use DateTimeInterface;

// This service for only check if certain actions on store subscription are applicable
class StoreSubscriptionCheckService
{
    private DateFactoryService $dateFactoryService;

    public function __construct(DateFactoryService $dateFactoryService)
    {
        $this->dateFactoryService = $dateFactoryService;
    }

    // Note: subtrahend is the quantity that we want to subtract from the remaining cars
    public function checkIfUpdateRemainingCarsAllowed(string $operationType, int $remainingCars, int $factor, int $packageCarsCount): bool|int
    {
        if ($operationType === SubscriptionConstant::OPERATION_TYPE_SUBTRACTION) {
            if ($remainingCars <= 0) {
                return false;

            } else {
                // remaining cars > 0
                // check if we do the subtraction the result is equal or bigger than zero
                if (($remainingCars - $factor) < 0) {
                    return false;

                } elseif (($remainingCars - $factor) >= 0) {
                    return true;
                }
            }

        } elseif ($operationType === SubscriptionConstant::OPERATION_TYPE_ADDITION) {
            if ($remainingCars === $packageCarsCount) {
                return false;

            } elseif ($remainingCars < $packageCarsCount) {
                if (($remainingCars + $factor) > $packageCarsCount) {
                    return false;
                }

                return true;
            }
        }

        return SubscriptionConstant::WRONG_SUBSCRIPTION_UPDATE_OPERATION_CONST;
    }

    // Note: subtrahend is the quantity that we want to subtract from the remaining orders
    public function checkIfUpdateRemainingOrdersAllowed(string $operationType, int $remainingOrders, int $factor, int $packageOrderCount): bool|int
    {
        if ($operationType === SubscriptionConstant::OPERATION_TYPE_SUBTRACTION) {
            if ($remainingOrders <= 0) {
                return false;

            } else {
                // remaining cars > 0
                // check if we do the subtraction the result is equal or bigger than zero
                if (($remainingOrders - $factor) < 0) {
                    return false;

                } elseif (($remainingOrders - $factor) >= 0) {
                    return true;
                }
            }

        } elseif ($operationType === SubscriptionConstant::OPERATION_TYPE_ADDITION) {
            if ($remainingOrders === $packageOrderCount) {
                return false;

            } elseif ($remainingOrders < $packageOrderCount) {
                if (($remainingOrders + $factor) > $packageOrderCount) {
                    return false;
                }

                return true;
            }
        }

        return SubscriptionConstant::WRONG_SUBSCRIPTION_UPDATE_OPERATION_CONST;
    }

    public function checkIfOrderBelongToStoreSubscriptionByOrderCreationDateAndSubscriptionValidationDate(DateTimeInterface $orderCreatedAt, DateTimeInterface $subscriptionStartDate, DateTimeInterface $subscriptionEndDate): bool
    {
        return $this->dateFactoryService->checkIfDateTimeInterfaceIsBetweenTwoDateTime($orderCreatedAt, $subscriptionStartDate,
            $subscriptionEndDate);
    }
}
