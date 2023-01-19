<?php

namespace App\Service\Admin\CaptainPayment;

use App\AutoMapping;
use App\Entity\CaptainPaymentToCompanyEntity;
use App\Manager\Admin\CaptainPayment\AdminCaptainPaymentToCompanyManager;
use App\Request\Admin\CaptainPayment\AdminCaptainPaymentCreateRequest;
use App\Request\Admin\CaptainPayment\CaptainPaymentToCompany\CaptainPaymentToCompanyUpdateAmountByAdminRequest;
use App\Response\Admin\CaptainPayment\AdminCaptainPaymentCreateResponse;
use App\Response\Admin\CaptainPayment\AdminCaptainPaymentResponse;
use App\Constant\Captain\CaptainConstant;
use App\Constant\Payment\PaymentConstant;
use App\Response\Admin\CaptainPayment\AdminCaptainPaymentDeleteResponse;
use App\Request\Admin\CaptainPayment\AdminCaptainPaymentToCompanyForOrderCashCreateRequest;
use App\Constant\Order\OrderAmountCashConstant;

class AdminCaptainPaymentToCompanyService
{
    private AutoMapping $autoMapping;
    private AdminCaptainPaymentToCompanyManager $adminCaptainPaymentToCompanyManager;

    public function __construct(AutoMapping $autoMapping, AdminCaptainPaymentToCompanyManager $adminCaptainPaymentToCompanyManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminCaptainPaymentToCompanyManager = $adminCaptainPaymentToCompanyManager;
    }

    public function createCaptainPaymentToCompany(AdminCaptainPaymentToCompanyForOrderCashCreateRequest $request): AdminCaptainPaymentCreateResponse|string
    {
        $payment = $this->adminCaptainPaymentToCompanyManager->createCaptainPaymentToCompany($request);
    
        if($payment === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST || $payment === OrderAmountCashConstant::NOT_ORDER_CASH) {
            return $payment;
        }

        return $this->autoMapping->map(CaptainPaymentToCompanyEntity::class, AdminCaptainPaymentCreateResponse::class, $payment);
    }

    public function deleteCaptainPaymentToCompany($id): AdminCaptainPaymentDeleteResponse|string
    {
        $payment = $this->adminCaptainPaymentToCompanyManager->deleteCaptainPaymentToCompany($id);
       
        if($payment ===  PaymentConstant::PAYMENT_NOT_EXISTS) {
            return $payment;
        }
       
        return $this->autoMapping->map(CaptainPaymentToCompanyEntity::class, AdminCaptainPaymentDeleteResponse::class, $payment);
    }

    public function getAllCaptainPaymentsToCompany(int $captainId): array
    {
        $response = [];

        $payments = $this->adminCaptainPaymentToCompanyManager->getAllCaptainPaymentsToCompany($captainId);

        foreach ($payments as $payment) {
           
            $response[] = $this->autoMapping->map('array', AdminCaptainPaymentResponse::class, $payment);
        }

        return $response;
    }

    public function getSumPaymentsToCompany(int $captainId): array
    {
       return $this->adminCaptainPaymentToCompanyManager->getSumPaymentsToCompany($captainId);
    }

    public function getSumPaymentsToCompanyInSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
       return $this->adminCaptainPaymentToCompanyManager->getSumPaymentsToCompanyInSpecificDate($captainId, $fromDate, $toDate);
    }

    public function updateCaptainPaymentToCompanyBySpecificAmount(CaptainPaymentToCompanyUpdateAmountByAdminRequest $request): CaptainPaymentToCompanyEntity|int
    {
        return $this->adminCaptainPaymentToCompanyManager->updateCaptainPaymentToCompanyBySpecificAmount($request);
    }
}
