<?php

namespace App\Service\Admin\CaptainPayment;

use App\Constant\CaptainPayment\PaymentToCaptain\CaptainPaymentConstant;
use App\Constant\CaptainPayment\PaymentToCaptain\CaptainPaymentResultConstant;
use App\Entity\CaptainPaymentEntity;
use App\Manager\Admin\CaptainPayment\AdminCaptainPaymentManager;

class AdminCaptainPaymentGetService
{
    public function __construct(
        private AdminCaptainPaymentManager $adminCaptainPaymentManager
    )
    {
    }

    public function getCaptainPaymentSumByCaptainProfileIdAndCaptainFinancialDemand(int $captainProfileId): float
    {
        $captainPaymentSumArray = $this->adminCaptainPaymentManager->getCaptainPaymentSumByCaptainProfileIdAndCaptainFinancialDemand($captainProfileId);

        if (count($captainPaymentSumArray) > 0) {
            return $captainPaymentSumArray[0];
        }

        return CaptainPaymentConstant::ZERO_PAYMENT_VALUE_CONST;
    }

    public function getLastCaptainPaymentByCaptainProfileId(int $captainProfileId): int|CaptainPaymentEntity
    {
        $captainPayment = $this->adminCaptainPaymentManager->getLastCaptainPaymentByCaptainProfileId($captainProfileId);

        if (count($captainPayment) > 0) {
            return $captainPayment[0];
        }

        return CaptainPaymentResultConstant::CAPTAIN_PAYMENT_NOT_EXIST;
    }
}
