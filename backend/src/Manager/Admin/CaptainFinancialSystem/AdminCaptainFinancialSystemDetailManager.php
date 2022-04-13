<?php

namespace App\Manager\Admin\CaptainFinancialSystem;

use App\Repository\CaptainFinancialSystemDetailEntityRepository;
use App\Manager\Captain\CaptainManager;

class AdminCaptainFinancialSystemDetailManager
{
    private CaptainFinancialSystemDetailEntityRepository $captainFinancialSystemDetailEntityRepository;

    public function __construct(CaptainFinancialSystemDetailEntityRepository $captainFinancialSystemDetailEntityRepository, CaptainManager $captainManager)
    {
        $this->captainFinancialSystemDetailEntityRepository = $captainFinancialSystemDetailEntityRepository;
        $this->captainManager = $captainManager;
    }

    public function getCaptainFinancialSystemDetailForAdmin(int $captainId): ?array
    {      
        return $this->captainFinancialSystemDetailEntityRepository->getCaptainFinancialSystemDetailCurrent($captainId);
    }

    public function getLatestFinancialCaptainSystemDetails(int $captainId): ?array
    {      
        return $this->captainFinancialSystemDetailEntityRepository->getLatestFinancialCaptainSystemDetailsForAdmin($captainId);
    }
}
