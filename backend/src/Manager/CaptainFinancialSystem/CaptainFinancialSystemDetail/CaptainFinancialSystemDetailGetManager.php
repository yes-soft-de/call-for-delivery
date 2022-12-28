<?php

namespace App\Manager\CaptainFinancialSystem\CaptainFinancialSystemDetail;

use App\Repository\CaptainFinancialSystemDetailEntityRepository;

class CaptainFinancialSystemDetailGetManager
{
    private CaptainFinancialSystemDetailEntityRepository $captainFinancialSystemDetailEntityRepository;

    public function __construct(CaptainFinancialSystemDetailEntityRepository $captainFinancialSystemDetailEntityRepository)
    {
        $this->captainFinancialSystemDetailEntityRepository = $captainFinancialSystemDetailEntityRepository;
    }

    public function getLastCaptainFinancialSystemDetailByCaptainUserId(int $captainUserId): array
    {
        return $this->captainFinancialSystemDetailEntityRepository->getLastCaptainFinancialSystemDetailByCaptainUserId($captainUserId);
    }
}
