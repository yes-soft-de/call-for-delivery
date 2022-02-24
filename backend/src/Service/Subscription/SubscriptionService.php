<?php

namespace App\Service\Subscription;

use App\AutoMapping;
use App\Entity\SubscriptionEntity;
use App\Manager\Subscription\SubscriptionManager;
use App\Request\Subscription\SubscriptionCreateRequest;
use App\Response\Subscription\SubscriptionResponse;
use App\Response\Subscription\SubscriptionByIdResponse;
use App\Response\Subscription\MySubscriptionsResponse;
use App\Response\Subscription\RemainingOrdersResponse;
use dateTime;
use App\Constant\Subscription\SubscriptionConstant;
use Doctrine\ORM\NonUniqueResultException;
use phpDocumentor\Reflection\Types\Integer;

class SubscriptionService
{
    public function __construct(private AutoMapping $autoMapping, private SubscriptionManager $subscriptionManager)
    {
        $this->autoMapping = $autoMapping;
        $this->subscriptionManager = $subscriptionManager;
    }

    /**
     * @param SubscriptionCreateRequest $request
     * @return mixed
     * @throws NonUniqueResultException
     */
    public function createSubscription(SubscriptionCreateRequest $request): mixed
    {
        $this->checkSubscription($request->getStoreOwner());
       
        $isFuture = $this->getIsFutureState($request->getStoreOwner());

        $request->setIsFuture($isFuture);

        $subscription = $this->subscriptionManager->createSubscription($request);

        return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $subscription);
    }

    /**
     * Check if there is a future subscription
     * @param storeOwner
     * @return INT
     */
    public function getIsFutureState($storeOwner): INT
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

    /**
     * @param storeOwner
     * @return RemainingOrdersResponse|string
     */
    public function packageBalance($storeOwner):RemainingOrdersResponse|string
    {
       $this->checkSubscription($storeOwner);
      
       $subscription = $this->subscriptionManager->getSubscriptionCurrentWithRelation($storeOwner);
       if($subscription) {

           return $this->autoMapping->map("array", RemainingOrdersResponse::class, $subscription);
       }

       return SubscriptionConstant::UNSUBSCRIBED;
    }

    /**
     * @param storeOwner
     * @return string
     */
    public function checkSubscription($storeOwner):string
    {
       $checkSubscription = $this->checkValidityOfSubscription($storeOwner);
      
       if($checkSubscription === SubscriptionConstant::UNSUBSCRIBED || $checkSubscription === SubscriptionConstant::ORDERS_FINISHED|| $checkSubscription === SubscriptionConstant::DATE_FINISHED) {

        //Is subscription for next time? yes -> update subscription current.
         return $this->updateIsFutureAndSubscriptionCurrent($storeOwner);
       }

       return SubscriptionConstant::UNSUBSCRIBED;
    }
    
    public function getSubscriptionsForStoreOwner($storeOwner): array
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

    public function checkValidityOfSubscription($storeOwner)
    {
        $subscription = $this->subscriptionManager->getSubscriptionCurrentWithRelation($storeOwner);
        //check and update RemainingTime
        $subscriptionExpired = $this->checkSubscriptionExpired($subscription);
        // $remainingTime = $this->updateRemainingTime($subscription);
       
       if($subscription) {
            if($subscription['subscriptionStatus'] === SubscriptionConstant::SUBSCRIBE_INACTIVE) {
           
                return SubscriptionConstant::SUBSCRIBE_INACTIVE;
            }
    
            if($subscription['remainingOrders'] <= 0) {
               
                $this->updateSubscribeState($subscription['id'], SubscriptionConstant::ORDERS_FINISHED);
    
                return SubscriptionConstant::ORDERS_FINISHED;
            }
    
            if($subscriptionExpired === SubscriptionConstant::DATE_FINISHED ) {
    
                $this->updateSubscribeState($subscription['id'], SubscriptionConstant::DATE_FINISHED);
    
                return SubscriptionConstant::DATE_FINISHED;
    
            }
    
            if($subscription['remainingCars'] <= 0) {
               
                $this->updateSubscribeState($subscription['id'], SubscriptionConstant::CARS_FINISHED);
    
                return SubscriptionConstant::CARS_FINISHED;
            }  
           
            if($subscription['subscriptionStatus'] === SubscriptionConstant::SUBSCRIBE_ACTIVE) {
           
                $this->updateSubscribeState($subscription['id'], SubscriptionConstant::SUBSCRIBE_ACTIVE);
    
                return SubscriptionConstant::SUBSCRIBE_ACTIVE;
            }
        }

        return SubscriptionConstant::UNSUBSCRIBED;
    }

    public function updateSubscribeState($id, $status): string
    {
        return $this->subscriptionManager->updateSubscribeState($id, $status);
    }

    // reduce the number of available orders
    public function updateRemainingOrders($storeOwner): string
    {
        $subscriptionCurrent = $this->subscriptionManager->getSubscriptionCurrent($storeOwner);

        if($subscriptionCurrent->getRemainingOrders() > 0) {
       
            $remainingOrders = $subscriptionCurrent->getRemainingOrders() - 1 ;
          
            $this->subscriptionManager->updateRemainingOrders($subscriptionCurrent->getLastSubscription(), $remainingOrders);
           
            return SubscriptionConstant::SUBSCRIPTION_OK;
        }

        return $this->checkSubscription($storeOwner);
    }

    public function checkSubscriptionExpired($subscription): string
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

    public function updateRemainingTime($subscription)
    {
       $remainingTime = "";
       
       if(isset($subscription['remainingTime'])) {
            if($subscription['remainingTime'] > 0) {
            
                //Get the remaining time by calculating the difference between the start date and the end date.
                $difference = $subscription['startDate']->diff($subscription['endDate']);
                if ($difference->d) {

                $remainingTime .= $difference->format("%d");
                }

                $this->subscriptionManager->updateRemainingTime($subscription['id'], $remainingTime);
            }
        }

        return $remainingTime;
    }

    public function updateIsFutureAndSubscriptionCurrent($storeOwner): string
    {
        $subscription = $this->subscriptionManager->getSubscriptionForNextTime($storeOwner);
  
        if($subscription) {
             
           $subscription = $this->subscriptionManager->updateIsFutureAndSubscriptionCurrent($subscription['id'], 0);
          
           return SubscriptionConstant::NEW_SUBSCRIPTION_ACTIVATED;
        }

        return SubscriptionConstant::UNSUBSCRIBED;
    }
}
