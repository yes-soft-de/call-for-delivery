<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemDetail;

use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemDetail\CaptainFinancialSystemDetailGetManager;

class CaptainFinancialSystemDetailGetService
{
    private CaptainFinancialSystemDetailGetManager $captainFinancialSystemDetailGetManager;

    public function __construct(CaptainFinancialSystemDetailGetManager $captainFinancialSystemDetailGetManager)
    {
        $this->captainFinancialSystemDetailGetManager = $captainFinancialSystemDetailGetManager;
    }

    public function getLastCaptainFinancialSystemDetailByCaptainUserId(int $captainUserId): array
    {
        return $this->captainFinancialSystemDetailGetManager->getLastCaptainFinancialSystemDetailByCaptainUserId($captainUserId);
    }
}
