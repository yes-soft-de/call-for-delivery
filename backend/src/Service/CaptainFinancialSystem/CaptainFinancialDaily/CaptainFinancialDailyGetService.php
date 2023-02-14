<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDaily;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyResultConstant;
use App\Entity\CaptainFinancialDailyEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyManager;
use App\Response\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyAmountGetForCaptainResponse;
use DateTime;

class CaptainFinancialDailyGetService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private CaptainFinancialDailyManager $captainFinancialDailyManager
    )
    {
    }

    public function getCaptainFinancialAmountDailyByCaptainUserIdAndSpecificDate(int $captainId, DateTime $date): int|CaptainFinancialDailyAmountGetForCaptainResponse
    {
        $captainFinancialDaily = $this->captainFinancialDailyManager->getCaptainFinancialAmountDailyByCaptainUserIdAndSpecificDate($captainId, $date);

        if (! $captainFinancialDaily) {
            return CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST;
        }

        return $this->autoMapping->map(CaptainFinancialDailyEntity::class, CaptainFinancialDailyAmountGetForCaptainResponse::class, $captainFinancialDaily);
    }
}
