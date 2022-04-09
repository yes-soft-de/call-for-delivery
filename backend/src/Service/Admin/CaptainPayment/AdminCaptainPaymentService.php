<?php

namespace App\Service\Admin\CaptainPayment;

use App\AutoMapping;
use App\Entity\CaptainPaymentEntity;
use App\Manager\Admin\CaptainPayment\AdminCaptainPaymentManager;
use App\Request\Admin\CaptainPayment\AdminCaptainPaymentCreateRequest;
use App\Response\Admin\CaptainPayment\AdminCaptainPaymentCreateResponse;
use App\Response\Admin\CaptainPayment\AdminCaptainPaymentResponse;
use App\Constant\Captain\CaptainConstant;
use App\Constant\Payment\PaymentConstant;
use App\Response\Admin\CaptainPayment\AdminCaptainPaymentDeleteResponse;

class AdminCaptainPaymentService
{
    private AutoMapping $autoMapping;
    private AdminCaptainPaymentManager $adminCaptainPaymentManager;

    public function __construct(AutoMapping $autoMapping, AdminCaptainPaymentManager $adminCaptainPaymentManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminCaptainPaymentManager = $adminCaptainPaymentManager;
    }

    public function createCaptainPayment(AdminCaptainPaymentCreateRequest $request): AdminCaptainPaymentCreateResponse|string
    {
        $payment = $this->adminCaptainPaymentManager->createCaptainPayment($request);
       
        if($payment === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return $payment;
        }

        return $this->autoMapping->map(CaptainPaymentEntity::class, AdminCaptainPaymentCreateResponse::class, $payment);
    }

    public function deleteCaptainPayment($id): AdminCaptainPaymentDeleteResponse|string
    {
        $payment = $this->adminCaptainPaymentManager->deleteCaptainPayment($id);
       
        if($payment ===  PaymentConstant::PAYMENT_NOT_EXISTS) {
            return $payment;
        }
       
        return $this->autoMapping->map(CaptainPaymentEntity::class, AdminCaptainPaymentDeleteResponse::class, $payment);
    }

    public function getAllCaptainPayments(int $captainId): array
    {
        $response = [];

        $payments = $this->adminCaptainPaymentManager->getAllCaptainPayments($captainId);

        foreach ($payments as $payment) {
           
            $response[] = $this->autoMapping->map('array', AdminCaptainPaymentResponse::class, $payment);
        }

        return $response;
    }
}
