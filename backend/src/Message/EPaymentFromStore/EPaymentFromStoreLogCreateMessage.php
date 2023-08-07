<?php

namespace App\Message\EPaymentFromStore;

class EPaymentFromStoreLogCreateMessage
{
    private int $createdByUserId;

    private ?int $ePaymentFromStore;

    // the int value refers to the resulting action of the payment
    private int $action;

    private ?string $details;

    private ?int $storeOwnerProfile;

    private ?int $adminProfile;

    public static function create(int $createdByUserId, int $action, ?int $storeOwnerProfile = null, ?int $ePaymentFromStore = null, ?int $adminProfile = null, ?string $details = null): self
    {
        $ePaymentFromStoreLogCreateMessage = new EPaymentFromStoreLogCreateMessage();

        $ePaymentFromStoreLogCreateMessage->ePaymentFromStore = $ePaymentFromStore;
        $ePaymentFromStoreLogCreateMessage->action = $action;
        $ePaymentFromStoreLogCreateMessage->details = $details;
        $ePaymentFromStoreLogCreateMessage->createdByUserId = $createdByUserId;
        $ePaymentFromStoreLogCreateMessage->storeOwnerProfile = $storeOwnerProfile;
        $ePaymentFromStoreLogCreateMessage->adminProfile = $adminProfile;

        return $ePaymentFromStoreLogCreateMessage;
    }

    public function getEPaymentFromStore(): ?int
    {
        return $this->ePaymentFromStore;
    }

    public function getAction(): int
    {
        return $this->action;
    }

    public function getDetails(): ?string
    {
        return $this->details;
    }

    public function getCreatedByUserId(): int
    {
        return $this->createdByUserId;
    }

    public function getStoreOwnerProfile(): ?int
    {
        return $this->storeOwnerProfile;
    }

    public function getAdminProfile(): ?int
    {
        return $this->adminProfile;
    }
}
