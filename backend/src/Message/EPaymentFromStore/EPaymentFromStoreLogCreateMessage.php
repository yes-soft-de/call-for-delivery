<?php

namespace App\Message\EPaymentFromStore;

class EPaymentFromStoreLogCreateMessage
{
    private int $ePaymentFromStore;

    // the int value refers to the resulting action of the payment
    private int $action;

    private ?string $details;

    public static function create(int $ePaymentFromStore, int $action, ?string $details = null): self
    {
        $ePaymentFromStoreLogCreateMessage = new EPaymentFromStoreLogCreateMessage();

        $ePaymentFromStoreLogCreateMessage->ePaymentFromStore = $ePaymentFromStore;
        $ePaymentFromStoreLogCreateMessage->action = $action;
        $ePaymentFromStoreLogCreateMessage->details = $details;

        return $ePaymentFromStoreLogCreateMessage;
    }

    public function getEPaymentFromStore(): int
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
}
