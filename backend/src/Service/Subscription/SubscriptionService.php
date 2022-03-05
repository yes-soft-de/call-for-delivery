<?php

namespace App\Service\Subscription;

use App\AutoMapping;
use App\Entity\SubscriptionEntity;
use App\Manager\Subscription\SubscriptionManager;
use App\Request\Subscription\SubscriptionCreateRequest;
use App\Response\Subscription\SubscriptionResponse;
use App\Response\Subscription\MySubscriptionsResponse;
use App\Response\Subscription\RemainingOrdersResponse;
use App\Response\Subscription\CanCreateOrderResponse;
use App\Constant\Subscription\SubscriptionConstant;

class SubscriptionService
{
    private $autoMapping;
    private $subscriptionManager;

    public function __construct(AutoMapping $autoMapping, SubscriptionManager $subscriptionManager)
    {
        $this->autoMapping = $autoMapping;
        $this->subscriptionManager = $subscriptionManager;
    }
    
    public function createSubscription(SubscriptionCreateRequest $request): mixed
    {
        $this->checkSubscription($request->getStoreOwner());
       
        $isFuture = $this->getIsFutureState($request->getStoreOwner());

        $request->setIsFuture($isFuture);

        $subscription = $this->subscriptionManager->createSubscription($request);

        return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $subscription);
    }

    public function getIsFutureState(int $storeOwner): INT
    {
        $subscriptionCurrent = $this->subscriptionManager->getSubscriptionCurrent($storeOwner);
        if($subscriptionCurrent) {
            if($subscriptionCurrent->getStatus() === SubscriptionConstant::SUBSCRIBE_ACTIVE) {
             
                return  SubscriptionConstant::IS_FUTURE_TRUE;
            }

            return  SubscriptionConstant::IS_FUTURE_FALSE;
        }

        return  SubscriptionConstant::IS_FUTURE_FALSE;
    }

    public function packageBalance(int $storeOwnerId): RemainingOrdersResponse|string
    {
       $this->checkSubscription($storeOwnerId);
      
       $subscription = $this->subscriptionManager->getSubscriptionCurrentWithRelation($storeOwnerId);
       if($subscription) {
           $countOrders = $this->getCountOngoingOrders($subscription['id']);

           $subscription['remainingCars'] = $subscription['remainingCars'] - $countOrders;

           return $this->autoMapping->map("array", RemainingOrdersResponse::class, $subscription);
       }

       $subscription['status'] = SubscriptionConstant::UNSUBSCRIBED;
      
       return $this->autoMapping->map("array", RemainingOrdersResponse::class, $subscription);
    }

    public function checkSubscription(int $storeOwnerId): string
    {
       $checkSubscription = $this->checkValidityOfSubscription($storeOwnerId);
      
       if($checkSubscription === SubscriptionConstant::UNSUBSCRIBED || $checkSubscription === SubscriptionConstant::ORDERS_FINISHED|| $checkSubscription === SubscriptionConstant::DATE_FINISHED) {

        //Is subscription for next time? yes -> update subscription current.
         return $this->updateIsFutureAndSubscriptionCurrent($storeOwnerId);
       }

       return SubscriptionConstant::UNSUBSCRIBED;
    }

    public function getSubscriptionsForStoreOwner(int $storeOwner): array
    {
       $response = [];
      
       $this->checkSubscription($storeOwner);

       $subscriptions = $this->subscriptionManager->getSubscriptionsForStoreOwner($storeOwner);

       foreach ($subscriptions as $subscription) {
            if($subscription['subscriptionDetailsId']) {
             
                $subscription['isCurrent'] = SubscriptionConstant::SUBSCRIBE_CURRENT;
            }

            $response[] = $this->autoMapping->map("array", MySubscriptionsResponse::class, $subscription);
        }

        return $response;
    }

    public function checkValidityOfSubscription(int $storeOwnerId): string
    {
        $subscription = $this->subscriptionManager->getSubscriptionCurrentWithRelation($storeOwnerId);
        //check and update RemainingTime
        $subscriptionExpired = $this->checkSubscriptionExpired($subscription);
        
        $remainingCars = $this->checkRemainingCars($subscription);
       
       if($subscription) {
            if($subscription['subscriptionStatus'] === SubscriptionConstant::SUBSCRIBE_INACTIVE) {
           
                return SubscriptionConstant::SUBSCRIBE_INACTIVE;
            }
            
            //all cars are busy
            if($remainingCars === SubscriptionConstant::CARS_FINISHED) {

                $this->updateSubscribeState($subscription['id'], SubscriptionConstant::CARS_FINISHED);
    
                return SubscriptionConstant::CARS_FINISHED;
            }  

            //orders are finished
            if($subscription['remainingOrders'] <= 0) {
               
                $this->updateSubscribeState($subscription['id'], SubscriptionConstant::ORDERS_FINISHED);
    
                return SubscriptionConstant::ORDERS_FINISHED;
            }
    
            //date is finished
            if($subscriptionExpired === SubscriptionConstant::DATE_FINISHED ) {
    
                $this->updateSubscribeState($subscription['id'], SubscriptionConstant::DATE_FINISHED);
    
                return SubscriptionConstant::DATE_FINISHED;
    
            } 
        
            //there cars available
            if($remainingCars === SubscriptionConstant::SUBSCRIPTION_OK) {
           
                $this->updateSubscribeState($subscription['id'], SubscriptionConstant::SUBSCRIBE_ACTIVE);
    
                return SubscriptionConstant::SUBSCRIBE_ACTIVE;
            }
        }

        return SubscriptionConstant::UNSUBSCRIBED;
    }

    public function updateSubscribeState(int $id, string $status): string
    {
        return $this->subscriptionManager->updateSubscribeState($id, $status);
    }

    public function updateRemainingOrders(int $storeOwnerId): string
    {
        $subscriptionCurrent = $this->subscriptionManager->getSubscriptionCurrent($storeOwnerId);
        if($subscriptionCurrent) {
            if($subscriptionCurrent->getRemainingOrders() > 0) {
       
                $remainingOrders = $subscriptionCurrent->getRemainingOrders() - 1 ;
              
                $this->subscriptionManager->updateRemainingOrders($subscriptionCurrent->getLastSubscription()->getId(), $remainingOrders);
               
                return SubscriptionConstant::SUBSCRIPTION_OK;
            }
        }

        return $this->checkSubscription($storeOwnerId);
    }

    public function checkSubscriptionExpired(null|array|SubscriptionEntity $subscription): string
    {       
        if($subscription) {

            $dateNow = new \DateTime('now');
            //Is the subscription expired?
            if($subscription['endDate'] < $dateNow ) {
                //Is there extra time?
                if($subscription['remainingTime'] > 0) {

                  $subscription['endDate'] =  new \DateTime($subscription['endDate']->format('Y-m-d h:i:s') . $subscription['remainingTime'].'day');
                  //update end date and remainingTime and note
                  $this->subscriptionManager->updateEndDate($subscription['id'], $subscription['endDate'], SubscriptionConstant::SUBSCRIPTION_EXTRA_TIME);

                  return SubscriptionConstant::SUBSCRIPTION_OK;                
                }

                return SubscriptionConstant::DATE_FINISHED;
            }
            
            return SubscriptionConstant::YOU_DO_NOT_HAVE_SUBSCRIBED;

        }

        return SubscriptionConstant::YOU_DO_NOT_HAVE_SUBSCRIBED;
    }

    /**
     * Get count of ongoing orders within the current subscription date
     */
    public function getCountOngoingOrders(int $subscriptionId): ?int
    { 
        $countOrders = $this->subscriptionManager->countOrders($subscriptionId);

        return $countOrders['countOrders'];
    }

    public function checkRemainingCars(null|SubscriptionEntity|array $subscription): string
    {       
        if($subscription) {
            $countOrders = $this->getCountOngoingOrders($subscription['id']);

           if($subscription['remainingCars'] - $countOrders <= 0 ) {

                return SubscriptionConstant::CARS_FINISHED;
           }

           return SubscriptionConstant::SUBSCRIPTION_OK;
        }

        return SubscriptionConstant::YOU_DO_NOT_HAVE_SUBSCRIBED;
    }

    public function updateIsFutureAndSubscriptionCurrent(int $storeOwnerId): string
    {
        $subscription = $this->subscriptionManager->getSubscriptionForNextTime($storeOwnerId);
  
        if($subscription) {
             
           $this->subscriptionManager->updateIsFutureAndSubscriptionCurrent($subscription['id'], 0);
          
           return SubscriptionConstant::NEW_SUBSCRIPTION_ACTIVATED;
        }

        return SubscriptionConstant::UNSUBSCRIBED;
    }

    public function canCreateOrder(int $storeOwnerId): CanCreateOrderResponse
    {
      $packageBalance = $this->packageBalance($storeOwnerId);
      
      if($packageBalance !== SubscriptionConstant::UNSUBSCRIBED) {

        $item['subscriptionStatus'] = $packageBalance->status;

        if($packageBalance->status ===  SubscriptionConstant::SUBSCRIBE_ACTIVE) {
         
          $item['canCreateOrder'] = SubscriptionConstant::CAN_CREATE_ORDER;
        }
        else{
  
          $item['canCreateOrder'] = SubscriptionConstant::CAN_NOT_CREATE_ORDER;
        }
      
        return $this->autoMapping->map("array", CanCreateOrderResponse::class, $item);
      }

      $item['subscriptionStatus'] = SubscriptionConstant::UNSUBSCRIBED;
      $item['canCreateOrder'] = SubscriptionConstant::CAN_NOT_CREATE_ORDER;

      return $this->autoMapping->map("array", CanCreateOrderResponse::class, $item);
    }
}
