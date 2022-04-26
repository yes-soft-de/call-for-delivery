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

    public int $flag;

    /**
     * @OA\Property(type="array", property="paymentsFromStore",
     *     @OA\Items(type="object",
     *              ref=@Model(type="App\Response\StoreOwnerPayment\StoreOwnerPaymentResponse"),
     * ))
     */
    public array $paymentsFromStore;
}
