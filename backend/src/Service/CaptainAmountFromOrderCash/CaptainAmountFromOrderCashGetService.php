<?php

namespace App\Service\CaptainAmountFromOrderCash;

use App\Constant\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashConstant;
use App\Entity\CaptainAmountFromOrderCashEntity;
use App\Manager\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashManager;

class CaptainAmountFromOrderCashGetService
{
    public function __construct(
        private CaptainAmountFromOrderCashManager $captainAmountFromOrderCashManager
    )
    {
    }

    public function getCaptainAmountFromOrderCashByOrderId(int $orderId): CaptainAmountFromOrderCashEntity|int
    {
        $captainAmountFromOrderCash = $this->captainAmountFromOrderCashManager->getCaptainAmountFromOrderCashByOrderId($orderId);

        if (! $captainAmountFromOrderCash) {
            return CaptainAmountFromOrderCashConstant::CAPTAIN_AMOUNT_FROM_ORDER_CASH_NOT_EXIST_CONST;
        }

        return $captainAmountFromOrderCash;
    }
}
