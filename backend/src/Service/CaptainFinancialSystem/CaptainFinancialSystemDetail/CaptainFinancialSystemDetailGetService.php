<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemDetail;

use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemDetail\CaptainFinancialSystemDetailGetManager;

class CaptainFinancialSystemDetailGetService
{
    public function __construct(
        private CaptainFinancialSystemDetailGetManager $captainFinancialSystemDetailGetManager
    )
    {
    }

    public function getLastCaptainFinancialSystemDetailByCaptainUserId(int $captainUserId): array
    {
        return $this->captainFinancialSystemDetailGetManager->getLastCaptainFinancialSystemDetailByCaptainUserId($captainUserId);
    }

    /**
     * Get all captain financial system details except captainFinancialSystemType = 4
     */
    public function getAllCaptainFinancialSystemDetailsExceptFinancialDefaultSystem(): array
    {
        return $this->captainFinancialSystemDetailGetManager->getAllCaptainFinancialSystemDetailsExceptFinancialDefaultSystem();
    }
}
