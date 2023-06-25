<?php

namespace App\Request\EPayment;

use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionEntity;

class EPaymentCreateByStoreOwnerRequest
{
    private int $status;

    // could be store owner user id, store owner profile id, or store owner profile entity
    private int|StoreOwnerProfileEntity $storeOwnerProfile;

    private ?int $paymentFor;

    private ?int $paymentGetaway;

    private ?float $amount;

    private ?string $paymentId;

    private int|null|SubscriptionEntity $subscription = null;

    private int $paymentType;

    private int $createdBy;

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

    public function setPaymentId(?string $paymentId): void
    {
        $this->paymentId = $paymentId;
    }

    public function getPaymentType(): int
    {
        return $this->paymentType;
    }

    public function setPaymentType(int $paymentType): void
    {
        $this->paymentType = $paymentType;
    }

    public function setPaymentFor(?int $paymentFor): void
    {
        $this->paymentFor = $paymentFor;
    }

    public function getPaymentFor(): ?int
    {
        return $this->paymentFor;
    }

    public function setPaymentGetaway(?int $paymentGetaway): void
    {
        $this->paymentGetaway = $paymentGetaway;
    }

    public function setAmount(?float $amount): void
    {
        $this->amount = $amount;
    }

    public function setCreatedBy(int $createdBy): void
    {
        $this->createdBy = $createdBy;
    }
}
