<?php

namespace App\Request\Admin\StoreOwnerPreference;

use App\Entity\StoreOwnerProfileEntity;

class StoreOwnerPreferenceCreateByAdminRequest
{
    private int|StoreOwnerProfileEntity $storeOwnerProfile;

    private ?float $subscriptionCostLimit;

    public function getStoreOwnerProfile(): int|StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfile;
    }

    public function setStoreOwnerProfile(int|StoreOwnerProfileEntity $storeOwnerProfile): void
    {
        $this->storeOwnerProfile = $storeOwnerProfile;
    }

    public function getSubscriptionCostLimit(): ?float
    {
        return $this->subscriptionCostLimit;
    }

    public function setSubscriptionCostLimit(?float $subscriptionCostLimit): void
    {
        $this->subscriptionCostLimit = $subscriptionCostLimit;
    }
}
