<?php

namespace App\Response\Subscription;

class CanCreateOrderResponse
{
    public ?bool $canCreateOrder;

    public ?string $subscriptionStatus;

    public ?string $percentageOfOrdersConsumed;

    public ?string $packageName;

    public ?int $packageType;

    public bool $hasToPay = false;

    public bool $firstTimeSubscriptionWithUniformPackage = false;
}
