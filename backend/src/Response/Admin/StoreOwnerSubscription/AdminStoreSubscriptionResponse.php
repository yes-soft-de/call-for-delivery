<?php

namespace App\Response\Admin\StoreOwnerSubscription;

use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Model;
use DateTime;

class AdminStoreSubscriptionResponse
{
    public int $id;

    public string $packageName;

    public DateTime $startDate;

    public DateTime $endDate;

    /**
     * @var string|null
     */
    public $status;

    /**
     * @var string|null
     */
    public $note;

    public int|null $flag;
    
    /**
     * @OA\Property(type="array", property="paymentsFromStore",
     *     @OA\Items(
     *              ref=@Model(type="App\Response\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentResponse")
     * ))
     */
    public $paymentsFromStore;

    /**
     * @OA\Property(type="object", property="total",
     *              @OA\Property(type="number", property="total"),
     *              @OA\Property(type="number", property="packageCost"),
     *              @OA\Property(type="number", property="sumPayments"),
     *              @OA\Property(type="boolean", property="advancePayment")
     * 
     * )
     */
    public $total;

    /**
     * @OA\Property(type="array", property="captainOffers",
     *     @OA\Items(type="object")
     *   )
     */
    public $captainOffers;

    public int $packageCarCount;

    public int $packageOrderCount;

    public int $packageExpired;

    /**
     * @var string|null
     */
    public $packageNote;

    public bool $isFuture;

    public int $remainingCars;

    public int $remainingOrders;

    public int $subscriptionRemainingOrders;

    public int $subscriptionRemainingCars;

    public bool $isCurrent;

    public float $countOfConsumedOrders;
    
    /**
     * @OA\Property(type="array", property="ordersExceedGeographicalRange",
     *     @OA\Items(type="object"))
     */
    public $ordersExceedGeographicalRange;
}
