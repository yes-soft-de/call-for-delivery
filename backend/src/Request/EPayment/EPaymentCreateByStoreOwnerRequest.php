<?php

namespace App\Request\EPayment;

use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionEntity;

class EPaymentCreateByStoreOwnerRequest
{
    private int $status;

    private int|StoreOwnerProfileEntity $storeOwnerProfile;

    private ?int $paymentFor;

    private ?int $paymentGetaway;

    private ?float $amount;

    private ?string $clientAddress = null;

    private ?string $paymentId;

    private int|null|SubscriptionEntity $subscription = null;

    public function getStatus(): int
    {
        return $this->status;
    }

    public function getStoreOwnerProfile(): int|StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfile;
    }

    public function setStoreOwnerProfile(int|StoreOwnerProfileEntity $storeOwnerProfile): void
    {
        $this->storeOwnerProfile = $storeOwnerProfile;
    }

    public function setSubscription(SubscriptionEntity|int|null $subscription): void
    {
        $this->subscription = $subscription;
    }
}
