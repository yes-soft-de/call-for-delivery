<?php

namespace App\Response\Admin\StoreOwnerPreference;

use DateTime;

class StoreOwnerPreferenceGetForAdminResponse
{
    public int $id;

    public ?float $subscriptionCostLimit;

    public DateTime $createdAt;

    public DateTime $updatedAt;
}
