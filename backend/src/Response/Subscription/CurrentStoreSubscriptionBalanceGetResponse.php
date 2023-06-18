<?php

namespace App\Response\Subscription;

use DateTime;

class CurrentStoreSubscriptionBalanceGetResponse
{
    public int $deliveredOrdersCount;

    public float $deliveredOrdersCostsSum;

    public ?float $openingOrderCost;

    public ?float $oneKilometerCost;

    public ?string $subscriptionStatus;

    public bool $hasToPay;

    public ?DateTime $subscriptionStartDate;
}
