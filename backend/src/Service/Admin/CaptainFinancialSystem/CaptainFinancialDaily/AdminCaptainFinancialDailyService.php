<?php

namespace App\Service\Admin\CaptainFinancialSystem\CaptainFinancialDaily;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyResultConstant;
use App\Constant\Order\OrderAmountCashConstant;
use App\Entity\CaptainFinancialDailyEntity;
use App\Manager\Admin\CaptainFinancialSystem\CaptainFinancialDaily\AdminCaptainFinancialDailyManager;
use App\Request\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyIsPaidUpdateByAdminRequest;
use App\Response\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyIsPaidUpdateByAdminResponse;
use App\Service\DateFactory\DateFactoryService;
use DateTime;
use DateTimeInterface;

class AdminCaptainFinancialDailyService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminCaptainFinancialDailyManager $adminCaptainFinancialDailyManager,
        private DateFactoryService $dateFactoryService
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

    public function getDateTimeOnlyFromDateTimeInterface(DateTimeInterface $dateTimeInterface): DateTime
    {
        return $this->dateFactoryService->getDateTimeOnlyFromDateTimeInterface($dateTimeInterface);
    }

    public function subtractingValueFromCaptainFinancialDailyAlreadyHadAmount(float $value, int $captainProfileId, DateTimeInterface $orderCreationDate): ?CaptainFinancialDailyEntity
    {
        $orderCreatedAt = $this->getDateTimeOnlyFromDateTimeInterface($orderCreationDate);

        return $this->adminCaptainFinancialDailyManager->subtractingValueFromCaptainFinancialDailyAlreadyHadAmount($value,
            $captainProfileId, $orderCreatedAt);
    }

    /**
     * Updates alreadyHadAmount field of Captain Financial Daily according to group of Captain Amount from Cash Orders
     */
    public function updateCaptainFinancialDailyAlreadyHadAmountByGroup(array $captainAmountFromCashOrders)
    {
        foreach ($captainAmountFromCashOrders as $captainAmountFromCashOrderEntity) {
            // Subtract amount field of the related captain financial daily, depending on captain and order creation date
            // and only if the amount is paid from captain to admin
            if (($captainAmountFromCashOrderEntity->getFlag() === OrderAmountCashConstant::ORDER_PAID_FLAG_YES)
                && ($captainAmountFromCashOrderEntity->getEditingByCaptain() === false)) {
                $this->subtractingValueFromCaptainFinancialDailyAlreadyHadAmount($captainAmountFromCashOrderEntity->getAmount(),
                    $captainAmountFromCashOrderEntity->getCaptain()->getId(), $captainAmountFromCashOrderEntity->getOrderId()->getCreatedAt());
            }
        }
    }
}
