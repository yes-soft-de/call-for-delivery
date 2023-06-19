<?php

namespace App\Request\Admin\StoreOwner;

class StoreOwnerProfileOpeningSubscriptionWithoutPaymentUpdateRequest
{
    private int $id;

    private bool $openingSubscriptionWithoutPayment;

    public function getId(): int
    {
        return $this->id;
    }

    public function isOpeningSubscriptionWithoutPayment(): bool
    {
        return $this->openingSubscriptionWithoutPayment;
    }
}
