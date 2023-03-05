<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemDetail;

use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemDetail\CaptainFinancialSystemDetailGetManager;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemDetailManager;

class CaptainFinancialSystemDetailGetService
{
    public function __construct(
        private CaptainFinancialSystemDetailGetManager $captainFinancialSystemDetailGetManager,
        //private CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager
    )
    {
    }

    public function getLastCaptainFinancialSystemDetailByCaptainUserId(int $captainUserId): array
    {
        return $this->captainFinancialSystemDetailGetManager->getLastCaptainFinancialSystemDetailByCaptainUserId($captainUserId);
    }

//    /**
//     * Get Captain Financial System Detail entity
//     */
//    public function getCaptainFinancialSystemDetailEntityByCaptainUserId(int $captainUserId): CaptainFinancialSystemDetailEntity|string
//    {
//        $captainFinancialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailEntityByCaptainUserId($captainUserId);
//
//        if (! $captainFinancialSystemDetail) {
//            return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
//        }
//
//        return $captainFinancialSystemDetail;
//    }
}
