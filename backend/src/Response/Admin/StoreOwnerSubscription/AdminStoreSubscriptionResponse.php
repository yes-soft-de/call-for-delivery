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

    public int $flag;
    
    /**
     * @OA\Property(type="array", property="paymentsFromStore",
     *     @OA\Items(type="object",
     *              ref=@Model(type="App\Response\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentResponse"),
     * ))
     */
    public array $paymentsFromStore;
}
