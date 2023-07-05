<?php

namespace App\Response\Subscription;

use DateTime;

class RemainingOrdersResponse
{
    /**
     * current subscription id
     */
    public ?int $id;

    public ?int $packageId;

    public ?string $packageName;

    public ?int $remainingOrders;

    public ?int $remainingCars;

    public ?string $status;

    public ?DateTime $startDate;

    public ?DateTime $endDate;

    public ?int $packageCarCount;

    public ?int $packageOrderCount;

    public ?int $expired;

    public ?bool $canSubscriptionExtra;

    // The sum of unpaid cash orders
    public float $unPaidCashOrdersSum;

    public ?int $packageType;

    public ?float $geographicalRange;

    public ?float $packageExtraCost;
}
