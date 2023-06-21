<?php

namespace App\Request\Admin\StoreOwnerPreference;

class StoreOwnerPreferenceUpdateByAdminRequest
{
    private int $id;

    private ?float $subscriptionCostLimit;

    public function getId(): int
    {
        return $this->id;
    }
}
