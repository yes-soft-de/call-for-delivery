<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDue;

use App\Constant\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashConstant;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
use App\Constant\Order\OrderResultConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Entity\CaptainAmountFromOrderCashEntity;
use App\Entity\CaptainFinancialDuesEntity;
use App\Service\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashGetService;
use App\Service\CaptainFinancialSystem\CaptainFinancialDuesService;
use DateTimeInterface;

class CaptainFinancialDueAmountForStoreUpdateHandlerService
{
    public function __construct(
        private CaptainAmountFromOrderCashGetService $captainAmountFromOrderCashGetService,
        private CaptainFinancialDuesService $captainFinancialDuesService
    )
    {
    }

    public function getCaptainAmountFromOrderCashByOrderId(int $orderId): CaptainAmountFromOrderCashEntity|int
    {
        return $this->captainAmountFromOrderCashGetService->getCaptainAmountFromOrderCashByOrderId($orderId);
    }

    public function subtractValueFromCaptainFinancialDueAmountForStore(int $captainUserId, DateTimeInterface $orderCreatedAt, float $value): CaptainFinancialDuesEntity|int
    {
        return $this->captainFinancialDuesService->subtractValueFromCaptainFinancialDueAmountForStore($captainUserId,
            $orderCreatedAt, $value);
    }

    public function addValueToCaptainFinancialDueAmountForStore(int $captainUserId, DateTimeInterface $orderCreatedAt, float $value): CaptainFinancialDuesEntity|int
    {
        return $this->captainFinancialDuesService->addValueToCaptainFinancialDueAmountForStore($captainUserId,
            $orderCreatedAt, $value);
    }

    /**
     * Main function
     * Updates amountForStore field of the captain financial due according to captains' previous and new answer about
     * paying cash order amount to the store or not
     */
    public function handleUpdatingCaptainFinancialDueAmountForStore(int $captainUserId, int $orderId, DateTimeInterface $orderCreationDate, float $captainOrderCost, int $paidToProvider): CaptainFinancialDuesEntity|int
    {
        // 1 Get CaptainAmountFromOrderCash by specific captain and order
        $previousAnswer = $this->getCaptainAmountFromOrderCashByOrderId($orderId);

        if ($previousAnswer === CaptainAmountFromOrderCashConstant::CAPTAIN_AMOUNT_FROM_ORDER_CASH_NOT_EXIST_CONST) {
            return CaptainAmountFromOrderCashConstant::CAPTAIN_AMOUNT_FROM_ORDER_CASH_NOT_EXIST_CONST;
        }

        // 2 If CaptainAmountFromOrderCash exist, check it with the new captain answer
        if ($previousAnswer->getFlag() === $paidToProvider) {
            // do nothing
            return CaptainFinancialDues::AMOUNT_FOR_STORE_NO_NEED_TO_BE_UPDATED_CONST;

        } elseif ($previousAnswer->getFlag() === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_YES
            && $paidToProvider === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
            // update amountForStore by order cost addition
            return $this->addValueToCaptainFinancialDueAmountForStore($captainUserId, $orderCreationDate, $captainOrderCost);

        } elseif ($previousAnswer->getFlag() === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO
            && $paidToProvider === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_YES) {
            // update amountForStore by order cost subtraction
            return $this->subtractValueFromCaptainFinancialDueAmountForStore($captainUserId, $orderCreationDate, $captainOrderCost);
        }

        return OrderResultConstant::ORDER_PAID_TO_PROVIDER_WRONG_ANSWER_CONST;
    }

    /**
     * Subtracts the amount of specific CaptainAmountFromOrderCash from the filed
     * amountForStore of the CaptainFinancialDue
     */
    public function subtractSpecificCaptainAmountFromOrderCashFromCaptainFinancialDue(int $captainUserId, int $orderId, DateTimeInterface $orderCreationDate): CaptainFinancialDuesEntity|int
    {
        // 1 Get CaptainAmountFromOrderCash by specific captain and order
        $captainAmountFromOrderCash = $this->getCaptainAmountFromOrderCashByOrderId($orderId);

        if ($captainAmountFromOrderCash === CaptainAmountFromOrderCashConstant::CAPTAIN_AMOUNT_FROM_ORDER_CASH_NOT_EXIST_CONST) {
            return CaptainAmountFromOrderCashConstant::CAPTAIN_AMOUNT_FROM_ORDER_CASH_NOT_EXIST_CONST;
        }

        return $this->subtractValueFromCaptainFinancialDueAmountForStore($captainUserId, $orderCreationDate,
            $captainAmountFromOrderCash->getAmount());
    }
}
