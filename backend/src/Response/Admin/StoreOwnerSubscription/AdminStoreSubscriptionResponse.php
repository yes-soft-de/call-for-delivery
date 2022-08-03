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

    public string|null $status;

    public string|null $note;

    public int|null $flag;
    
    /**
     * @OA\Property(type="array", property="paymentsFromStore",
     *     @OA\Items(type="object",
     *              ref=@Model(type="App\Response\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentResponse"),
     * ))
     */
    public array $paymentsFromStore;

    /**
     * @OA\Property(type="object", property="total",
     *              @OA\Property(type="number", property="total"),
     *              @OA\Property(type="number", property="packageCost"),
     *              @OA\Property(type="number", property="sumPayments"),
     *              @OA\Property(type="boolean", property="advancePayment"),
     * 
     * )
     */
    public array $total;

    /**
     * @OA\Property(type="array", property="captainOffers",
     *     @OA\Items(type="object",
     *          @OA\Property(type="integer", property="id"),  
     *          @OA\Property(type="object", property="startDate"),  
     *          @OA\Property(type="number", property="price"),  
     *          @OA\Property(type="integer", property="carCount"),  
     *          @OA\Property(type="integer", property="expired"),  
     *          @OA\Property(type="string", property="status"),  
     *      )
     *   )
     */
    public $captainOffers;

    public int $packageCarCount;

    public int $packageOrderCount;

    public int $packageExpired;

    public string|null $packageNote;

    public bool $isFuture;

    public int $remainingCars;

    public int $remainingOrders;

    public int $subscriptionRemainingOrders;

    public int $subscriptionRemainingCars;

    public bool $isCurrent;
}
