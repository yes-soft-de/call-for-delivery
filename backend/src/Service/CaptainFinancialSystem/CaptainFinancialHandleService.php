<?php

namespace App\Service\CaptainFinancialSystem;

use App\Constant\Captain\CaptainConstant;
use App\Service\Captain\CaptainGetService;
use App\Service\CaptainOrderFinancialService\OrderFinancialValueGetService;
use DateTimeInterface;

class CaptainFinancialHandleService
{
    public function __construct(
        private CaptainGetService $captainGetService,
        private OrderFinancialValueGetService $orderFinancialValueGetService,
        private CaptainFinancialDuesService $captainFinancialDuesService
    )
    {
    }

    public function getCaptainProfileIdByCaptainUserId(int $captainUserId): int|string
    {
        //return $this->captainGetService->getCaptainProfileIdByCaptainUserId($captainUserId);
    }

    // Get the financial value that the order will add to the financial dues of the captain if he/she accept the order
    public function getSingleOrderFinancialValueByCaptainUserId(int $captainUserId, float $orderDistance = null): float
    {
//        $captainProfileId = $this->getCaptainProfileIdByCaptainUserId($captainUserId);
//
//        if ($captainProfileId === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
//            return 0.0;
//        }
//
//        return $this->orderFinancialValueGetService->getSingleOrderFinancialValueByCaptainUserId($captainProfileId, $captainUserId, $orderDistance);
    }

    public function createOrUpdateCaptainFinancialDue(int $captainUserId, DateTimeInterface $orderCreatedAt, float $amount, float $amountForStore)
    {
//        $this->captainFinancialDuesService->createOrUpdateCaptainFinancialDue($captainUserId, $orderCreatedAt, $amount,
//            $amountForStore);
    }

    public function addHalfOrderFinancialValueToCaptainFinancialDue(int $captainUserId, DateTimeInterface $orderCreatedAt, float $orderDistance = null)
    {
        // First, get the financial value of the order
//        $orderFinancialValue = $this->getSingleOrderFinancialValueByCaptainUserId($captainUserId, $orderDistance);
//
//        $halfOrderFinancialValue = $orderFinancialValue / 2.0;
//
//        // Update Captain Financial Due of the financial cycle which the order belongs to
//        $this->createOrUpdateCaptainFinancialDue($captainUserId, $orderCreatedAt, $halfOrderFinancialValue, 0.0);

        // Update Captain Financial Daily of the day that the order belongs to
    }
}
