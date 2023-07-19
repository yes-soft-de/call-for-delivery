<?php

namespace App\Manager\CaptainFinancialSystem\CaptainFinancialSystemDetail;

use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Repository\CaptainFinancialSystemDetailEntityRepository;

class CaptainFinancialSystemDetailGetManager
{
    public function __construct(
        private CaptainFinancialSystemDetailEntityRepository $captainFinancialSystemDetailEntityRepository)
    {
    }

    public function getLastCaptainFinancialSystemDetailByCaptainUserId(int $captainUserId): array
    {
        return $this->captainFinancialSystemDetailEntityRepository->getLastCaptainFinancialSystemDetailByCaptainUserId($captainUserId);
    }

    /**
     * Get all captain financial system details except captainFinancialSystemType = 4
     */
    public function getAllCaptainFinancialSystemDetailsExceptFinancialDefaultSystem(): array
    {
        return $this->captainFinancialSystemDetailEntityRepository->findBy(['captainFinancialSystemType' => CaptainFinancialSystem::FIRST_THREE_CAPTAIN_FINANCIAL_SYSTEMS_ARRAY_CONST]);
    }
}
