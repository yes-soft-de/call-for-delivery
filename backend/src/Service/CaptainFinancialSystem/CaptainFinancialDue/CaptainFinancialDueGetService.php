<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDue;

use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
use App\Entity\CaptainFinancialDuesEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialDuesManager;

class CaptainFinancialDueGetService
{
    public function __construct(
        private CaptainFinancialDuesManager $captainFinancialDuesManager)
    {
    }

    public function getLatestCaptainFinancialDues(int $captainId): ?array
    {
        return $this->captainFinancialDuesManager->getLatestCaptainFinancialDues($captainId);
    }

    public function getCurrentAndActiveCaptainFinancialDueByCaptainProfileId(int $captainProfileId): int|CaptainFinancialDuesEntity
    {
        $captainFinancialDue = $this->captainFinancialDuesManager->getCurrentAndActiveCaptainFinancialDueByCaptainProfileId($captainProfileId);

        if (count($captainFinancialDue) > 0) {
            return $captainFinancialDue[0];
        }

        return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
    }
}
