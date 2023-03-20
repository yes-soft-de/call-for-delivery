<?php

namespace App\Response\Subscription;

use DateTime;

class RemainingOrdersResponse
{
    /**
     * @var int|null
     */
    public $id;

    /**
     * @var int|null
     */
    public $packageId;

    /**
     * @var string|null
     */
    public $packageName;

    /**
     * @var int|null
     */
    public $remainingOrders;

    /**
     * @var int|null
     */
    public $remainingCars;

    /**
     * @var string|null
     */
    public $status;

    /**
     * @var DateTime|null
     */
    public $startDate;

    /**
     * @var DateTime|null
     */
    public $endDate;

    /**
     * @var int|null
     */
    public $packageCarCount;

    /**
     * @var int|null
     */
    public $packageOrderCount;

    /**
     * @var int|null
     */
    public $expired;

    /**
     * @var bool|null
     */
    public $canSubscriptionExtra;

    // The sum of unpaid cash orders
    public float $unPaidCashOrdersSum;

    /**
     * @var int|null
     */
    public $packageType;

    /**
     * @var float|null
     */
    public $geographicalRange;

    /**
     * @var float|null
     */
    public $packageExtraCost;
}
