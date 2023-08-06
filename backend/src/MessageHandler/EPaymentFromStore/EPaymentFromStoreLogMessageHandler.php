<?php

namespace App\MessageHandler\EPaymentFromStore;

use App\Message\EPaymentFromStore\EPaymentFromStoreLogCreateMessage;
use App\Service\EPaymentFromStoreLog\EPaymentFromStoreLogToMySqlService;
use Symfony\Component\Messenger\Attribute\AsMessageHandler;

#[AsMessageHandler]
class EPaymentFromStoreLogMessageHandler
{
    public function __construct(
        private EPaymentFromStoreLogToMySqlService $ePaymentFromStoreLogToMySqlService
    )
    {
    }

    public function __invoke(EPaymentFromStoreLogCreateMessage $ePaymentFromStoreLogCreateMessage)
    {

    }

    public function handleCreateEPaymentFromStoreLogMessage()
    {

    }
}
