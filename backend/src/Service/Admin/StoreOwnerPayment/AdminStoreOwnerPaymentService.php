<?php

namespace App\Service\Admin\StoreOwnerPayment;

use App\AutoMapping;
use App\Entity\StoreOwnerPaymentEntity;
use App\Manager\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentManager;
use App\Request\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentCreateRequest;
use App\Response\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentCreateResponse;
use App\Response\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentResponse;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\Payment\PaymentConstant;
use App\Response\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentDeleteResponse;

class AdminStoreOwnerPaymentService
{
    private AutoMapping $autoMapping;
    private AdminStoreOwnerPaymentManager $adminStoreOwnerPaymentManager;

    public function __construct(AutoMapping $autoMapping, AdminStoreOwnerPaymentManager $adminStoreOwnerPaymentManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminStoreOwnerPaymentManager = $adminStoreOwnerPaymentManager;
    }

    public function createStoreOwnerPayment(AdminStoreOwnerPaymentCreateRequest $request): AdminStoreOwnerPaymentCreateResponse|string
    {
        $payment = $this->adminStoreOwnerPaymentManager->createStoreOwnerPayment($request);
       
        if($payment === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return $payment;
        }

        return $this->autoMapping->map(StoreOwnerPaymentEntity::class, AdminStoreOwnerPaymentCreateResponse::class, $payment);
    }

    public function deleteStoreOwnerPayment($id): AdminStoreOwnerPaymentDeleteResponse|string
    {
        $payment = $this->adminStoreOwnerPaymentManager->deleteStoreOwnerPayment($id);
       
        if($payment ===  PaymentConstant::PAYMENT_NOT_EXISTS) {
            return $payment;
        }
       
        return $this->autoMapping->map(StoreOwnerPaymentEntity::class, AdminStoreOwnerPaymentDeleteResponse::class, $payment);
    }

    public function getAllStorePayments(int $storeId): array
    {
        $response = [];

        $payments = $this->adminStoreOwnerPaymentManager->getAllStorePayments($storeId);

        foreach ($payments as $payment) {
           
            $response[] = $this->autoMapping->map('array', AdminStoreOwnerPaymentResponse::class, $payment);
        }

        return $response;
    }
}
