<?php

namespace App\Service\Admin\StoreOwnerSubscription;

use App\AutoMapping;
use App\Manager\Admin\StoreOwnerSubscription\AdminStoreSubscriptionManager;
use App\Response\Admin\StoreOwnerSubscription\AdminStoreSubscriptionResponse;
use App\Service\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentService;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;

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
          
            $subscription['captainOffer'] = $this->adminStoreSubscriptionManager->getCaptainOfferFirstTimeBySubscriptionId($subscription['id']);

            $captainOfferPrice = 0;
            if ($subscription['captainOffer']) {
                $captainOfferPrice =  $subscription['captainOffer']['price'];
            }

            $subscription['total'] = $this->getTotal($subscription['paymentsFromStore'], $subscription['packageCost'], $captainOfferPrice);

            $response[] = $this->autoMapping->map("array", AdminStoreSubscriptionResponse::class, $subscription);
        }

        return $response;
    }

    public function getTotal(array $payments, float $packageCost, float $captainOfferPrice): array
    {
        $item['sumPayments'] = array_sum(array_map(fn ($payment) => $payment->amount, $payments));
      
        $item['packageCost'] = $packageCost;

        $item['captainOfferPrice'] = $captainOfferPrice;
      
        $total = ($packageCost + $captainOfferPrice) - $item['sumPayments'];
       
        $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;
    
        if($total <= 0 ) {
            $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;    
        }

        $item['total'] = abs($total);
        
        return  $item;
    }
}
 