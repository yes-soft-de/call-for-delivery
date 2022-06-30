<?php

namespace App\Service\Admin\StoreOwnerSubscription;

use App\AutoMapping;
use App\Entity\SubscriptionEntity;
use App\Manager\Admin\StoreOwnerSubscription\AdminStoreSubscriptionManager;
use App\Response\Admin\StoreOwnerSubscription\AdminStoreSubscriptionResponse;
use App\Response\Admin\StoreOwnerSubscription\StoreFutureSubscriptionGetForAdminResponse;
use App\Service\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentService;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Service\Subscription\SubscriptionService;

class AdminStoreSubscriptionService
{
    private AutoMapping $autoMapping;
    private AdminStoreSubscriptionManager $adminStoreSubscriptionManager;
    private AdminStoreOwnerPaymentService $adminStoreOwnerPaymentService;
    private SubscriptionService $subscriptionService;

    public function __construct(AutoMapping $autoMapping, AdminStoreSubscriptionManager $adminStoreSubscriptionManager, AdminStoreOwnerPaymentService $adminStoreOwnerPaymentService, SubscriptionService $subscriptionService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminStoreSubscriptionManager = $adminStoreSubscriptionManager;
        $this->adminStoreOwnerPaymentService = $adminStoreOwnerPaymentService;
        $this->subscriptionService = $subscriptionService;
    }

    public function getSubscriptionsWithPaymentsSpecificStore(int $storeId): array
    {
       $response = [];
       //check Subscription
       $this->subscriptionService->packageBalanceForAdminByStoreOwnerProfileId($storeId);

       $subscriptions = $this->adminStoreSubscriptionManager->getSubscriptionsSpecificStoreForAdmin($storeId);

       foreach ($subscriptions as $subscription) {

            $subscription['paymentsFromStore'] = $this->adminStoreOwnerPaymentService->getStorePaymentsBySubscriptionId($subscription['id']);
          
            $subscription['captainOffers'] = $this->adminStoreSubscriptionManager->getCaptainOffersBySubscriptionId($subscription['id']);

            $subscription['total'] = $this->getTotal($subscription['paymentsFromStore'], $subscription['packageCost'], $subscription['captainOffers']);

            $response[] = $this->autoMapping->map("array", AdminStoreSubscriptionResponse::class, $subscription);
        }

        return $response;
    }

    public function getTotal(array $payments, float $packageCost, array $captainOffers): array
    {
        $item['sumPayments'] = array_sum(array_map(fn ($payment) => $payment->amount, $payments));
      
        $sumCaptainOfferPrices = array_sum(array_map(fn ($captainOffer) => $captainOffer['price'], $captainOffers));
      
        $item['packageCost'] = $packageCost;

        $item['captainOfferPrice'] = $sumCaptainOfferPrices;
      
        $total = ($packageCost + $sumCaptainOfferPrices) - $item['sumPayments'];
       
        $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;
    
        if($total <= 0 ) {
            $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;    
        }

        $item['total'] = abs($total);
        
        return  $item;
    }

    // This functions deletes only future subscriptions of a store according to storeOwnerId
    public function deleteAllStoreFutureSubscriptionsByStoreOwnerId(int $storeOwnerId): array
    {
        $futureSubscriptionsResult = $this->adminStoreSubscriptionManager->deleteAllStoreFutureSubscriptionsByStoreOwnerId($storeOwnerId);

        if (! empty($futureSubscriptionsResult)) {
            $response = [];

            foreach ($futureSubscriptionsResult as $futureSubscriptionEntity) {
                $response[] = $this->autoMapping->map(SubscriptionEntity::class, StoreFutureSubscriptionGetForAdminResponse::class, $futureSubscriptionEntity);
            }

            return $response;
        }

        return $futureSubscriptionsResult;
    }
}
 