<?php

namespace App\Service\Admin\StoreOwnerPayment;

use App\AutoMapping;
use App\Entity\StoreOwnerPaymentEntity;
use App\Manager\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentManager;
use App\Request\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentCreateRequest;
use App\Request\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentUpdateRequest;
use App\Response\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentCreateResponse;
use App\Response\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentResponse;

class AdminStoreOwnerPaymentService
{
    private AutoMapping $autoMapping;
    private AdminStoreOwnerPaymentManager $adminStoreOwnerPaymentManager;

    public function __construct(AutoMapping $autoMapping, AdminStoreOwnerPaymentManager $adminStoreOwnerPaymentManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminStoreOwnerPaymentManager = $adminStoreOwnerPaymentManager;
    }

    public function createStoreOwnerPayment(AdminStoreOwnerPaymentCreateRequest $request): AdminStoreOwnerPaymentCreateResponse
    {
        $payment = $this->adminStoreOwnerPaymentManager->createStoreOwnerPayment($request);

        return $this->autoMapping->map(StoreOwnerPaymentEntity::class, AdminStoreOwnerPaymentCreateResponse::class, $payment);
    }

    public function updateStoreOwnerPayment(AdminStoreOwnerPaymentUpdateRequest $request): ?AdminStoreOwnerPaymentCreateResponse  
    {
        $payment = $this->adminStoreOwnerPaymentManager->updateStoreOwnerPayment($request);

        return $this->autoMapping->map(StoreOwnerPaymentEntity::class, AdminStoreOwnerPaymentCreateResponse::class, $payment);
    }

    public function getAllStorePayments(int $storeId): ?array
    {
        $response = [];

        $payments = $this->adminStoreOwnerPaymentManager->getAllStorePayments($storeId);

        foreach ($payments as $payment) {
           
            $response[] = $this->autoMapping->map('array', AdminStoreOwnerPaymentResponse::class, $payment);
        }

        return $response;
    }
}
