<?php

namespace App\Service\Admin\StoreOwnerPayment;

use App\AutoMapping;
use App\Entity\StoreOwnerPaymentFromCompanyEntity;
use App\Manager\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentFromCompanyManager;
use App\Request\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentFromCompanyForOrderCashCreateRequest;
use App\Request\Admin\StoreOwnerPayment\StoreOwnerPaymentFromCompanyUpdateAmountByAdminRequest;
use App\Response\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentCreateResponse;
use App\Response\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentFromCompanyResponse;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\Payment\PaymentConstant;
use App\Response\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentDeleteResponse;
use App\Constant\Order\OrderAmountCashConstant;

class AdminStoreOwnerPaymentFromCompanyService
{
    private AutoMapping $autoMapping;
    private AdminStoreOwnerPaymentFromCompanyManager $adminStoreOwnerPaymentFromCompanyManager;

    public function __construct(AutoMapping $autoMapping, AdminStoreOwnerPaymentFromCompanyManager $adminStoreOwnerPaymentFromCompanyManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminStoreOwnerPaymentFromCompanyManager = $adminStoreOwnerPaymentFromCompanyManager;
    }

    public function createStoreOwnerPaymentFromCompany(AdminStoreOwnerPaymentFromCompanyForOrderCashCreateRequest $request): AdminStoreOwnerPaymentCreateResponse|string
    {
        $payment = $this->adminStoreOwnerPaymentFromCompanyManager->createStoreOwnerPaymentFromCompany($request);
       
        if($payment === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS || $payment === OrderAmountCashConstant::NOT_ORDER_CASH) {
            return $payment;
        }

        return $this->autoMapping->map(StoreOwnerPaymentFromCompanyEntity::class, AdminStoreOwnerPaymentCreateResponse::class, $payment);
    }

    public function deleteStoreOwnerPaymentFromCompany($id): AdminStoreOwnerPaymentDeleteResponse|string
    {
        $payment = $this->adminStoreOwnerPaymentFromCompanyManager->deleteStoreOwnerPaymentFromCompany($id);
       
        if($payment ===  PaymentConstant::PAYMENT_NOT_EXISTS) {
            return $payment;
        }
       
        return $this->autoMapping->map(StoreOwnerPaymentFromCompanyEntity::class, AdminStoreOwnerPaymentDeleteResponse::class, $payment);
    }

    public function getAllStorePaymentsFromCompany(int $storeId): array
    {
        $response = [];

        $payments = $this->adminStoreOwnerPaymentFromCompanyManager->getAllStorePaymentsFromCompany($storeId);

        foreach ($payments as $payment) {
           
            $response[] = $this->autoMapping->map('array', AdminStoreOwnerPaymentFromCompanyResponse::class, $payment);
        }

        return $response;
    }

    public function getSumPaymentsFromCompany(int $storeId): array
    {
        return $this->adminStoreOwnerPaymentFromCompanyManager->getSumPaymentsFromCompany($storeId);
    }

    public function updateStoreOwnerPaymentFromCompanyBySpecificAmount(StoreOwnerPaymentFromCompanyUpdateAmountByAdminRequest $request): int|StoreOwnerPaymentFromCompanyEntity
    {
        return $this->adminStoreOwnerPaymentFromCompanyManager->updateStoreOwnerPaymentFromCompanyBySpecificAmount($request);
    }
}
