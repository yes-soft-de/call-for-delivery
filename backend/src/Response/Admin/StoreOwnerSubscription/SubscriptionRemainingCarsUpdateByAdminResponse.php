<?php

namespace App\Response\Admin\StoreOwnerSubscription;

class SubscriptionRemainingCarsUpdateByAdminResponse
{
    public int $id;

    public int $remainingOrders;

    public int $remainingCars;

    public int $remainingTime;

    public string $status;

    // Has extra time (The extra time is just one day)
    public bool $hasExtra;
}
