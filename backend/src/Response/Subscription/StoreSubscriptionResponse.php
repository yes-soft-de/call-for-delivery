<?php

namespace App\Response\Subscription;

use OpenApi\Annotations as OA;
use DateTime;
use Nelmio\ApiDocBundle\Annotation\Model;

class StoreSubscriptionResponse
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
     *              ref=@Model(type="App\Response\StorePayment\StoreOwnerPaymentResponse"),
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

    public array $captainOffers;
}
