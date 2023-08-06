<?php

namespace App\Service\EPaymentFromStoreLog;

use App\Manager\EPaymentFromStoreLog\EPaymentFromStoreLogManager;

class EPaymentFromStoreLogToMySqlService
{
    public function __construct(
        private EPaymentFromStoreLogManager $ePaymentFromStoreLogManager
    )
    {
    }
}
