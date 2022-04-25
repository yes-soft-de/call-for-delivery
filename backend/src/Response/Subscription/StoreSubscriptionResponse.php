<?php

namespace App\Response\Subscription;

use OpenApi\Annotations as OA;
use DateTime;

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
     * @OA\Property(type="array", property="paymentsFromCompany",
     *     @OA\Items(type="object"))
     */
    public array $paymentsFromStore;
}
