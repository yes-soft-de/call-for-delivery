<?php

namespace App\Service\StoreOwnerPayment;

use App\AutoMapping;
use App\Manager\StoreOwnerPayment\StoreOwnerPaymentManager;
use App\Response\StorePayment\StoreOwnerPaymentResponse;

class StoreOwnerPaymentService
{
    private AutoMapping $autoMapping;
    private StoreOwnerPaymentManager $storeOwnerPaymentManager;

    public function __construct( AutoMapping $autoMapping, StoreOwnerPaymentManager $storeOwnerPaymentManager)
    {
        $this->storeOwnerPaymentManager = $storeOwnerPaymentManager;
        $this->autoMapping = $autoMapping;
    }

    public function getStorePaymentsBySubscriptionId(int $subscriptionId): array
    {
        $response = [];

        $payments = $this->storeOwnerPaymentManager->getStorePaymentsBySubscriptionId($subscriptionId);
        
        foreach ($payments as $payment) {
           
            $response[] = $this->autoMapping->map('array', StoreOwnerPaymentResponse::class, $payment);
        }

        return $response;
    }
}
