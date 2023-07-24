<?php

namespace App\Service\CaptainPayment;

use App\Constant\CaptainPayment\PaymentToCaptain\CaptainPaymentConstant;
use App\Constant\CaptainPayment\PaymentToCaptain\CaptainPaymentResultConstant;
use App\Entity\CaptainPaymentEntity;
use App\Manager\CaptainPayment\CaptainPaymentManager;

class CaptainPaymentGetService
{
    public function __construct(
        private CaptainPaymentManager $captainPaymentManager
    )
    {
    }

    public function getLastCaptainPaymentByCaptainProfileId(int $captainProfileId): CaptainPaymentEntity|int
    {
        $captainPaymentArrayResult = $this->captainPaymentManager->getLastCaptainPaymentByCaptainProfileId($captainProfileId);

        if (count($captainPaymentArrayResult) > 0) {
            return $captainPaymentArrayResult[0];
        }

        return CaptainPaymentResultConstant::CAPTAIN_PAYMENT_NOT_EXIST;
    }

    public function getLastCaptainPaymentDateByCaptainProfileId(int $captainProfileId): \DateTimeInterface|int
    {
        $captainPayment = $this->getLastCaptainPaymentByCaptainProfileId($captainProfileId);

        if ($captainPayment === CaptainPaymentResultConstant::CAPTAIN_PAYMENT_NOT_EXIST) {
            return CaptainPaymentResultConstant::CAPTAIN_PAYMENT_NOT_EXIST;
        }

        return $captainPayment->getCreatedAt();
    }
}
