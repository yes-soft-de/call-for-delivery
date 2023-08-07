<?php

namespace App\Service\EPaymentFromStoreLog;

use App\Message\EPaymentFromStore\EPaymentFromStoreLogCreateMessage;
use Symfony\Component\Messenger\MessageBusInterface;

class EPaymentFromStoreLogDispatchService
{
    public function __construct(
        private MessageBusInterface $eventBus
    )
    {
    }

    public function dispatchEPaymentFromStoreCreateMessage(
        int $createdByUserId,
        int $action,
        ?int $storeOwnerProfile = null,
        ?int $ePaymentFromStore = null,
        ?int $adminProfile = null,
        ?string $details = null
    )
    {
        $this->eventBus->dispatch(EPaymentFromStoreLogCreateMessage::create($createdByUserId, $action, $storeOwnerProfile,
            $ePaymentFromStore, $adminProfile, $details));
    }
}
