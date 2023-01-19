<?php

namespace App\Request\Admin\Subscription\StoreSubscription;

class StoreSubscriptionRemainingCarsUpdateByAdminRequest
{
    // store subscription id
    private int $id;

    private int $remainingCars;

    // The number that we want to add/subtract to/from Remaining Cars field
    private int $factor;

    // Type of the required operation
    // Ex: "addition" or "subtraction"
    private string $operationType;

    public function getId(): int
    {
        return $this->id;
    }

    public function getRemainingCars(): int
    {
        return $this->remainingCars;
    }

    public function getFactor(): int
    {
        return $this->factor;
    }

    public function getOperationType(): string
    {
        return $this->operationType;
    }
}
