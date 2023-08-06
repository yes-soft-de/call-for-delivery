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

    public function dispatchEPaymentFromStoreCreateMessage(int $ePaymentFromStore, int $action, ?string $details = null)
    {
        $this->eventBus->dispatch(EPaymentFromStoreLogCreateMessage::create($ePaymentFromStore, $action, $details));
    }
}
