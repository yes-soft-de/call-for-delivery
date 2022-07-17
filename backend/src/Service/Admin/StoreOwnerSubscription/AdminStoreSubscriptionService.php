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
use App\Constant\Payment\PaymentConstant;
use App\Request\Admin\Subscription\AdminDeleteSubscriptionRequest;
use App\Request\Admin\Subscription\AdminCreateStoreSubscriptionRequest;
use App\Request\Subscription\SubscriptionCreateRequest;
use App\Response\Subscription\SubscriptionResponse;
use App\Response\Subscription\SubscriptionErrorResponse;
use App\Request\Admin\Subscription\AdminExtraSubscriptionForDayRequest;
use App\Response\Subscription\SubscriptionExtendResponse;
use App\Constant\Subscription\SubscriptionConstant;

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
      
            $subscription['isCurrent'] = SubscriptionConstant::SUBSCRIBE_NOT_CURRENT_BOOLEAN;
            
            if($subscription['subscriptionDetailsId']) {
                
                $subscription['isCurrent'] = SubscriptionConstant::SUBSCRIBE_CURRENT_BOOLEAN;
                $subscription['subscriptionRemainingCars'] = $subscription['remainingCars'];
                $subscription['subscriptionRemainingOrders'] = $subscription['remainingOrders'];
            }

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

    public function createSubscription(AdminCreateStoreSubscriptionRequest $requestByAdmin): SubscriptionResponse|SubscriptionErrorResponse|string|int
    {
      $request = new SubscriptionCreateRequest(); 
      $request->setPackage($requestByAdmin->getPackageId());
      $request->setNote($requestByAdmin->getNote());

      return $this->subscriptionService->createSubscriptionByAdmin($request, $requestByAdmin->getStoreProfileId()); 
    }

    public function extraSubscriptionForDayByAdmin(AdminExtraSubscriptionForDayRequest $request): SubscriptionExtendResponse|SubscriptionResponse|SubscriptionErrorResponse|int
    {

      return $this->subscriptionService->extraSubscriptionForDayByAdmin($request->getStoreProfileId()); 
    }
    
    public function deleteSubscriptionByAdmin(AdminDeleteSubscriptionRequest $request): StoreFutureSubscriptionGetForAdminResponse|null|int
    {
        //delete subscription with payments
        if($request->getDeletePayment() === PaymentConstant::DELETE_SUBSCRIPTION_WITH_PAYMENT) {
            $subscription = $this->adminStoreSubscriptionManager->deleteSubscriptionById($request->getId());
          
            $payments = $this->adminStoreOwnerPaymentService->getStorePaymentsBySubscriptionId($request->getId());
            foreach($payments as $payment){
                $this->adminStoreOwnerPaymentService->deleteStoreOwnerPayment($payment->id);
            }

            return $this->autoMapping->map(SubscriptionEntity::class, StoreFutureSubscriptionGetForAdminResponse::class, $subscription); 
        }

        // get payments with subscription id
        $payments = $this->adminStoreOwnerPaymentService->getStorePaymentsBySubscriptionId($request->getId());

        if($payments) {
            return PaymentConstant::THERE_ARE_PAYMENT_RELATED_WITH_SUBSCRIPTION;
        }
        //if not found payments , delete subscription
        if(! $payments) {
            $subscription = $this->adminStoreSubscriptionManager->deleteSubscriptionById($request->getId());
          
            return $this->autoMapping->map(SubscriptionEntity::class, StoreFutureSubscriptionGetForAdminResponse::class, $subscription); 
        }
    }
}
 