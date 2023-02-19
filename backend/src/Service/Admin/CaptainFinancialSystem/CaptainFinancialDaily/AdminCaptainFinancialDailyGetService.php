<?php

namespace App\Service\Admin\CaptainFinancialSystem\CaptainFinancialDaily;

use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyResultConstant;
use App\Entity\CaptainFinancialDailyEntity;
use App\Manager\Admin\CaptainFinancialSystem\CaptainFinancialDaily\AdminCaptainFinancialDailyManager;

class AdminCaptainFinancialDailyGetService
{
    public function __construct(
        private AdminCaptainFinancialDailyManager $captainFinancialDailyManager
    )
    {
    }

    public function getCaptainFinancialDailyById(int $captainFinancialDailyId): CaptainFinancialDailyEntity|int
    {
        $captainFinancialDaily = $this->captainFinancialDailyManager->getCaptainFinancialDailyById($captainFinancialDailyId);

        if (! $captainFinancialDaily) {
            return CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST;
        }

        return $captainFinancialDaily;
    }
}
