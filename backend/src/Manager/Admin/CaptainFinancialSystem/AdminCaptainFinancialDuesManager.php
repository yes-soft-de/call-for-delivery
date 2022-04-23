<?php

namespace App\Manager\Admin\CaptainFinancialSystem;

use App\Repository\CaptainFinancialDuesEntityRepository;

class AdminCaptainFinancialDuesManager
{
    private CaptainFinancialDuesEntityRepository $captainFinancialDuesRepository;

    public function __construct(CaptainFinancialDuesEntityRepository $captainFinancialDuesRepository)
    {
        $this->captainFinancialDuesRepository = $captainFinancialDuesRepository;
    }
    
    public function getCaptainFinancialDuesByCaptainId(int $captainId): array
    {
        return $this->captainFinancialDuesRepository->getCaptainFinancialDuesByCaptainId($captainId);
    } 
}
