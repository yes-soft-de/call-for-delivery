<?php

namespace App\Response\Admin\StoreOwnerSubscription;

use DateTime;

class CaptainOfferSubscriptionDeleteByAdminResponse
{
    public int $carCount;

    public string $status;

    public int $expired;

    public DateTime $startDate;

    public DateTime $updatedAt;
}
