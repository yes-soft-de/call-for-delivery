<?php

namespace App\Service\Subscription;

use App\AutoMapping;
use App\Entity\SubscriptionEntity;
use App\Manager\Subscription\SubscriptionManager;
use App\Request\Subscription\SubscriptionCreateRequest;
use App\Request\Subscription\SubscriptionNextRequest;
use App\Response\Subscription\SubscriptionResponse;
use App\Response\Subscription\SubscriptionByIdResponse;
use App\Response\Subscription\MySubscriptionsResponse;
use App\Response\Subscription\RemainingOrdersResponse;
use dateTime;
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

    public function createSubscription(SubscriptionCreateRequest $request)
    {
        $response = SubscriptionConstant::ERROR;

        $isFuture = $this->getIsFuture($request->getStoreOwner());
        if ( $isFuture == 0) {

            $status = SubscriptionConstant::SUBSCRIBE_INACTIVE;

            // $subscriptionCurrent = $this->getSubscriptionCurrent($request->getStoreOwner());
   
            // if($subscriptionCurrent) {
            //     $status = $this->subscriptionIsActive($request->getStoreOwner(), $subscriptionCurrent['id']);
            // }

            $subscriptionResult = $this->subscriptionManager->createSubscription($request, $status);

            $response = $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $subscriptionResult);
        }

        return $response;
    }
    
    public function nextSubscription(SubscriptionNextRequest $request)
    {
        $response="error";
        $IsFuture = $this->getIsFuture($request->getStoreOwner());
        if ( $IsFuture == 0)
        {
           $subscriptionCurrent = $this->getSubscriptionCurrent($request->getOwnerID());
        
           $status = $this->subscriptionIsActive($request->getOwnerID(), $subscriptionCurrent['id']);
           $subscriptionResult = $this->subscriptionManager->nextSubscription($request, $status);
            
           $response = $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $subscriptionResult);
        }
        return $response;
    }

    public function getIsFuture($storeOwner): INT
    {
        $item = $this->subscriptionManager->getIsFuture($storeOwner);
        if($item) {
         
            return $item['isFuture'];    
        }

        return 0;
    }

    public function getSubscriptionForStoreOwner($storeOwner): array
    {
       $response = [];

       $currentSubscription = $this->getSubscriptionCurrent($storeOwner);

    //    if ($currentSubscription) {
    //         $this->saveFinishAuto($ownerID, $currentSubscription['id']);
    //    }

       $subscriptions = $this->subscriptionManager->getSubscriptionForStoreOwner($storeOwner);

       foreach ($subscriptions as $subscription) {
          
             $subscription['isCurrent'] = SubscriptionConstant::SUBSCRIBE_NOT_CURRENT;
            
             if ($currentSubscription) {
//               $this->subscriptionIsActive($storeOwner, $currentSubscription['id']);

                 //Check if the subscription is the current subscription?
                 if ($subscription['id'] === $currentSubscription['id']) {

                     $subscription['isCurrent']= SubscriptionConstant::SUBSCRIBE_CURRENT;
                 }
               
                 else {

                     $subscription['isCurrent'] = SubscriptionConstant::SUBSCRIBE_NOT_CURRENT;
                 }
               
             }

            $response[] = $this->autoMapping->map("array", MySubscriptionsResponse::class, $subscription);
        }

        return $response;
    }
  
    public function subscriptionUpdateState($request)
    {
        $result = $this->subscriptionManager->subscriptionUpdateState($request);

        return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $result);
    }

    public function updateFinish($id, $status)
    {
        $result = $this->subscriptionManager->updateFinish($id, $status);
       
        return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $result);
    }

    public function changeIsFutureToFalse($id)
    {
        $result = $this->subscriptionManager->changeIsFutureToFalse($id);

        return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $result);
    }

    public function getSubscriptionsPending()
    {
        $response = [];
        $items = $this->subscriptionManager->getSubscriptionsPending();
       
        foreach ($items as $item) {
            $response[] = $this->autoMapping->map('array', SubscriptionByIdResponse::class, $item);
        }
        return $response;
    }
    
    public function getSubscriptionById($id)
    {
        $response = [];
        $items = $this->subscriptionManager->getSubscriptionById($id);
      
        foreach ($items as $item) {
            $response[] = $this->autoMapping->map('array', SubscriptionByIdResponse::class, $item);
        }
        return $response;
    }

    public function subscriptionIsActive($storeOwner, $subscribeId)
    {
        $res = $this->saveFinishAuto($storeOwner, $subscribeId);
        if($res->carsStatus){

            return SubscriptionConstant::CARS_FINISHED;
        }
 
        $item = $this->subscriptionManager->subscriptionIsActive($storeOwner, $subscribeId);
        if ($item) { 

          return  $item['status'];
        }       
     }

    // check subscription , if time is finish or order count is finish, change status value to 'finished'
    public function saveFinishAuto($storeOwner, $subscribeId)
    {
        $response = [];
        //Get full information for the current subscription
      
        $remainingOrdersOfPackage = $this->subscriptionManager->getRemainingOrders($storeOwner, $subscribeId);
        dd($remainingOrdersOfPackage);
        $countCancelledOrder = $this->subscriptionManager->getCountCancelledOrders($subscribeId);
        $countActiveCars = $this->subscriptionManager-> getCountActiveCars($storeOwner, $subscribeId);
        
        $remainingOrdersOfPackage['remainingOrders']= $remainingOrdersOfPackage['remainingOrderss'] + $countCancelledOrder['countCancelledOrder'];
      
        $remainingOrdersOfPackage['countActiveCars'] = $countActiveCars['countActiveCars'];
        $countDeliveredOrder = $this->subscriptionManager->getCountDeliveredOrders($storeOwner, $subscribeId);

        $remainingOrdersOfPackage['countOrdersDelivered'] = $countDeliveredOrder['countDeliveredOrders'];

        if ($remainingOrdersOfPackage['subscriptionEndDate']) {
   
            $startDate =$remainingOrdersOfPackage['subscriptionStartDate'];
            $endDate = date_timestamp_get($remainingOrdersOfPackage['subscriptionEndDate']);
            $endDate1 = $remainingOrdersOfPackage['subscriptionEndDate'];
            
            $now =date_timestamp_get(new DateTime("now"));

            if ($endDate1->format('y-m-d') != $startDate->format('y-m-d'))  {

            if ( $endDate <= $now)  {
    
                $this->updateFinish($remainingOrdersOfPackage['subscriptionID'], 'date finished');
                if($this->getNextSubscription($ownerID)) {
                    $this->changeIsFutureToFalse($this->getNextSubscription($ownerID));
                    }
                $response[] = ["subscripe finished, date is finished"];
            }

            if ($remainingOrdersOfPackage['remainingOrders'] == 0)  {
        
                $this->updateFinish($remainingOrdersOfPackage['subscriptionID'], 'orders finished');
                if($this->getNextSubscription($ownerID)) {
                $this->changeIsFutureToFalse($this->getNextSubscription($ownerID));
                }
                $response[] = ["subscripe finished, count Orders is finished"];
            }
               
            if ((int)$remainingOrdersOfPackage['packageCarCount'] - (int)$countActiveCars['countActiveCars'] == 0)  {
            $remainingOrdersOfPackage['carsStatus']= 'cars finished';
            $response[] = ["cars finished"];
                 }
         }   
        }


        $response = $this->autoMapping->map('array', RemainingOrdersResponse::class, $remainingOrdersOfPackage);
        $subscribeStatus = $this->subscriptionManager->subscriptionIsActive($ownerID, $subscribeId);
        
        if ($subscribeStatus['status']) {
            $response->subscriptionstatus = $subscribeStatus['status'];
        }
     
        return $response;
     }

    public function subscripeNewUsers($year, $month)
    {
       
        $fromDate =new \DateTime($year . '-' . $month . '-01'); 
        $toDate = new \DateTime($fromDate->format('Y-m-d') . ' 1 month');

        return $this->subscriptionManager->subscripeNewUsers($fromDate, $toDate);       
     }

    public function dashboardContracts($year, $month)
    {
        $response = [];

        $response[] = $this->subscriptionManager->countpendingContracts();
        $response[] = $this->subscriptionManager->countDoneContracts();
        $response[] = $this->subscripeNewUsers($year, $month);

        $subscriptionsPending = $this->subscriptionManager->getSubscriptionsPending();
       
        foreach ($subscriptionsPending as $item) {
            $response[] = $this->autoMapping->map('array', SubscriptionByIdResponse::class, $item);
        }
        
        return $response;
    }

    public function getSubscriptionCurrent($storeOwner): ?array
    {
        return $this->subscriptionManager->getSubscriptionCurrent($storeOwner);
    }

    public function getNextSubscription($storeOwner)
    {
        return $this->subscriptionManager->getNextSubscription($storeOwner);
    }

    public function packagebalance($storeOwner)
    {
        $response['subscriptionStatus']='unsubscribed';
        $subscribe = $this->getSubscriptionCurrent($storeOwner);
        
        if ($subscribe) {
           return $this->saveFinishAuto($storeOwner, $subscribe['id']);
        }
        return $response;
    }

    public function totalAmountOfSubscriptions($ownerID)
    {
        $items = $this->subscriptionManager->totalAmountOfSubscriptions($ownerID);
        foreach($items as $item)
        {
            if (isset($result[$item['totalAmountOfSubscriptions']]))
            {
                $result[$item['totalAmountOfSubscriptions']] += $item['totalAmountOfSubscriptions'];
            }
            else
            {
                $result[$item['totalAmountOfSubscriptions']] = $item['totalAmountOfSubscriptions'];
            }
        }
        if ($items ) {
            return array_sum($result);
        }
        return 0;
            
    }  
}
