<?php

namespace App\Service\Admin\CaptainPayment;

use App\AutoMapping;
use App\Entity\CaptainPaymentToCompanyEntity;
use App\Manager\Admin\CaptainPayment\AdminCaptainPaymentToCompanyManager;
use App\Request\Admin\CaptainPayment\CaptainPaymentToCompany\CaptainPaymentToCompanyUpdateAmountByAdminRequest;
use App\Response\Admin\CaptainPayment\AdminCaptainPaymentCreateResponse;
use App\Response\Admin\CaptainPayment\AdminCaptainPaymentResponse;
use App\Constant\Captain\CaptainConstant;
use App\Constant\Payment\PaymentConstant;
use App\Response\Admin\CaptainPayment\AdminCaptainPaymentDeleteResponse;
use App\Request\Admin\CaptainPayment\AdminCaptainPaymentToCompanyForOrderCashCreateRequest;
use App\Constant\Order\OrderAmountCashConstant;
use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialDuesService;
use App\Service\Admin\CaptainFinancialSystem\CaptainFinancialDaily\AdminCaptainFinancialDailyService;

class AdminCaptainPaymentToCompanyService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminCaptainPaymentToCompanyManager $adminCaptainPaymentToCompanyManager,
        private AdminCaptainFinancialDailyService $adminCaptainFinancialDailyService,
        private AdminCaptainFinancialDuesService $adminCaptainFinancialDuesService
    )
    {
    }

    public function createCaptainPaymentToCompany(AdminCaptainPaymentToCompanyForOrderCashCreateRequest $request): AdminCaptainPaymentCreateResponse|string
    {
        $payment = $this->adminCaptainPaymentToCompanyManager->createCaptainPaymentToCompany($request);

        if ($payment === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST || $payment === OrderAmountCashConstant::NOT_ORDER_CASH) {
            return $payment;
        }

        // As long as a payment from captain to admin had been made, then update both Captain Financial Due and
        // Captain Financial Daily
        // 1 Update alreadyHadAmount in Captain Financial Daily
        $this->updateCaptainFinancialDailyAlreadyHadAmountByGroup($payment[1]);
        // 2 Update amountForStore in Captain Financial Due
        $this->updateCaptainFinancialDueAmountForStoreByGroupOfCaptainAmountFromCashOrder($payment[1]);

        return $this->autoMapping->map(CaptainPaymentToCompanyEntity::class, AdminCaptainPaymentCreateResponse::class,
            $payment[0]);
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

    public function getSumPaymentsToCompanyInSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
       return $this->adminCaptainPaymentToCompanyManager->getSumPaymentsToCompanyInSpecificDate($captainId, $fromDate, $toDate);
    }

    public function updateCaptainPaymentToCompanyBySpecificAmount(CaptainPaymentToCompanyUpdateAmountByAdminRequest $request): CaptainPaymentToCompanyEntity|int
    {
        return $this->adminCaptainPaymentToCompanyManager->updateCaptainPaymentToCompanyBySpecificAmount($request);
    }

    /**
     * Updates alreadyHadAmount field of Captain Financial Daily according to group of Captain Amount from Cash Orders
     */
    public function updateCaptainFinancialDailyAlreadyHadAmountByGroup(array $captainAmountFromCashOrders)
    {
        if (count($captainAmountFromCashOrders) > 0) {
            $this->adminCaptainFinancialDailyService->updateCaptainFinancialDailyAlreadyHadAmountByGroup($captainAmountFromCashOrders);
        }
    }

    /**
     * Updates amountForStore field of Captain Financial Due according to group of Captain Amount from Cash Orders
     */
    public function updateCaptainFinancialDueAmountForStoreByGroupOfCaptainAmountFromCashOrder(array $captainAmountFromCashOrders)
    {
        if (count($captainAmountFromCashOrders) > 0) {
            $this->adminCaptainFinancialDuesService->updateCaptainFinancialDueAmountForStoreByGroupOfCaptainAmountFromCashOrder($captainAmountFromCashOrders);
        }
    }
}
