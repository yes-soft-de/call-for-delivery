<?php

namespace App\Service\Admin\CaptainFinancialSystem\CaptainFinancialDaily;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyResultConstant;
use App\Entity\CaptainFinancialDailyEntity;
use App\Manager\Admin\CaptainFinancialSystem\CaptainFinancialDaily\AdminCaptainFinancialDailyManager;
use App\Request\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyIsPaidUpdateByAdminRequest;
use App\Response\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyIsPaidUpdateByAdminResponse;

class AdminCaptainFinancialDailyService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminCaptainFinancialDailyManager $adminCaptainFinancialDailyManager
    )
    {
    }

    public function updateCaptainFinancialDailyIsPaid(CaptainFinancialDailyIsPaidUpdateByAdminRequest $request): int|CaptainFinancialDailyIsPaidUpdateByAdminResponse
    {
        $captainFinancialDaily = $this->adminCaptainFinancialDailyManager->updateCaptainFinancialDailyIsPaid($request);

        if ($captainFinancialDaily === CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST) {
            return CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST;
        }

        return $this->autoMapping->map(CaptainFinancialDailyEntity::class, CaptainFinancialDailyIsPaidUpdateByAdminResponse::class,
            $captainFinancialDaily);
    }
}
