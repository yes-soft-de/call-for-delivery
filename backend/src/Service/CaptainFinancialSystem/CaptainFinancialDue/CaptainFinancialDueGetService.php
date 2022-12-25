<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDue;

use App\Manager\CaptainFinancialSystem\CaptainFinancialDuesManager;

class CaptainFinancialDueGetService
{
    private CaptainFinancialDuesManager $captainFinancialDuesManager;

    public function __construct(CaptainFinancialDuesManager $captainFinancialDuesManager)
    {
        $this->captainFinancialDuesManager = $captainFinancialDuesManager;
    }

    public function getLatestCaptainFinancialDues(int $captainId): ?array
    {
        return $this->captainFinancialDuesManager->getLatestCaptainFinancialDues($captainId);
    }
}
