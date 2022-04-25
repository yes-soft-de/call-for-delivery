<?php

namespace App\Service\Admin\StoreOwnerSubscription;

use App\AutoMapping;
use App\Manager\Admin\StoreOwnerSubscription\AdminStoreSubscriptionManager;
use App\Response\Admin\StoreOwnerSubscription\AdminStoreSubscriptionResponse;
use App\Service\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentService;

class AdminStoreSubscriptionService
{
    private AutoMapping $autoMapping;
    private AdminStoreSubscriptionManager $adminStoreSubscriptionManager;
    private AdminStoreOwnerPaymentService $adminStoreOwnerPaymentService;

    public function __construct(AutoMapping $autoMapping, AdminStoreSubscriptionManager $adminStoreSubscriptionManager, AdminStoreOwnerPaymentService $adminStoreOwnerPaymentService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminStoreSubscriptionManager = $adminStoreSubscriptionManager;
        $this->adminStoreOwnerPaymentService = $adminStoreOwnerPaymentService;
    
    }

    public function getSubscriptionsWithPaymentsSpecificStore(int $storeId): array
    {
       $response = [];

       $subscriptions = $this->adminStoreSubscriptionManager->getSubscriptionsSpecificStoreForAdmin($storeId);

       foreach ($subscriptions as $subscription) {

            $subscription['paymentsFromStore'] = $this->adminStoreOwnerPaymentService->getStorePaymentsBySubscriptionId($subscription['id']);
         
            $response[] = $this->autoMapping->map("array", AdminStoreSubscriptionResponse::class, $subscription);
        }

        return $response;
    }
}
 