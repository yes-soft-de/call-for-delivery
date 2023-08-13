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
        ?int $storeOwnerProfileId = null,
        ?int $ePaymentFromStoreId = null,
        ?int $adminProfileId = null,
        ?string $details = null
    )
    {
        $this->eventBus->dispatch(EPaymentFromStoreLogCreateMessage::create($createdByUserId, $action, $storeOwnerProfileId,
            $ePaymentFromStoreId, $adminProfileId, $details));
    }
}
