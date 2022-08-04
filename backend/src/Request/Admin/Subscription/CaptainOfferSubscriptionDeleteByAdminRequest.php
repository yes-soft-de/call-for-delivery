<?php

namespace App\Request\Admin\Subscription;

class CaptainOfferSubscriptionDeleteByAdminRequest
{
    private int $storeSubscriptionId;

    // take 1 if we want to delete the captain offer even it is being used
    // take 0 if we want to delete the captain offer just if it is not being used yet.
    private int $deleteEvenItIsBeingUsed;

    public function getStoreSubscriptionId(): int
    {
        return $this->storeSubscriptionId;
    }

    public function getDeleteEvenItIsBeingUsed(): int
    {
        return $this->deleteEvenItIsBeingUsed;
    }
}
