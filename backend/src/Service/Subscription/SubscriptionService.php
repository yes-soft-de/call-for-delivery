<?php

namespace App\Service\Subscription;

use App\AutoMapping;
use App\Entity\SubscriptionEntity;
use App\Entity\SubscriptionDetailsEntity;
use App\Manager\Subscription\SubscriptionManager;
use App\Request\Subscription\SubscriptionCreateRequest;
use App\Response\Subscription\SubscriptionResponse;
use App\Response\Subscription\SubscriptionByIdResponse;
use App\Response\Subscription\MySubscriptionsResponse;
use App\Response\Subscription\RemainingOrdersResponse;
use dateTime;
use App\Constant\Subscription\SubscriptionConstant;
use Doctrine\ORM\NonUniqueResultException;

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
              
        $isFuture = $this->getIsFutureState($request->getStoreOwner());
            // dd( $isFuture);
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
             
                return  1;
            }

            return  0;
        }

        return  0;
    }

    /**
     * @param storeOwner
     * @return RemainingOrdersResponse|string
     */
    public function packageBalance($storeOwner):RemainingOrdersResponse|string
    {
        $subscription = $this->subscriptionManager->getSubscriptionCurrentWithRelation($storeOwner);
       if($subscription) {
       
        return $this->autoMapping->map("array", RemainingOrdersResponse::class, $subscription);
       }

       return SubscriptionConstant::UNSUBSCRIBED;
    }
    
    public function getSubscriptionsForStoreOwner($storeOwner): array
    {
       $response = [];

       $subscriptions = $this->subscriptionManager->getSubscriptionsForStoreOwner($storeOwner);

       foreach ($subscriptions as $subscription) {
            if($subscription['subscriptionDetailsId']) {
             
                $subscription['isCurrent'] = "yes";
            }

            $response[] = $this->autoMapping->map("array", MySubscriptionsResponse::class, $subscription);
        }

        return $response;
    }
















//     public function getSubscriptionForStoreOwner($storeOwner): array
//     {
//        $response = [];

//        $currentSubscription = $this->getSubscriptionCurrent($storeOwner);

//     //    if ($currentSubscription) {
//     //         $this->checkValidityOfSubscription($ownerID, $currentSubscription['id']);
//     //    }

//        $subscriptions = $this->subscriptionManager->getSubscriptionForStoreOwner($storeOwner);

//        foreach ($subscriptions as $subscription) {
          
//              $subscription['isCurrent'] = SubscriptionConstant::SUBSCRIBE_NOT_CURRENT;
            
//              if ($currentSubscription) {
// //               $this->subscriptionIsActive($storeOwner, $currentSubscription['id']);

//                  //Check if the subscription is the current subscription?
//                  if ($subscription['id'] === $currentSubscription['id']) {

//                      $subscription['isCurrent']= SubscriptionConstant::SUBSCRIBE_CURRENT;
//                  }
               
//                  else {

//                      $subscription['isCurrent'] = SubscriptionConstant::SUBSCRIBE_NOT_CURRENT;
//                  }
               
//              }

//             $response[] = $this->autoMapping->map("array", MySubscriptionsResponse::class, $subscription);
//         }

//         return $response;
//     }
  
    // public function subscriptionUpdateState($request)
    // {
    //     $result = $this->subscriptionManager->subscriptionUpdateState($request);

    //     return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $result);
    // }

    public function updateSubscribeStateToFinish($id, $status): string
    {
        return $this->subscriptionManager->updateSubscribeStateToFinish($id, $status);
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

    /**
     * @param $id
     * @return mixed
     * @throws NonUniqueResultException
     */
    public function subscriptionIsActive($id):mixed
    {
        // $res = $this->checkValidityOfSubscription($storeOwner, $subscribeId);
        // if($res->carsStatus){

        //     return SubscriptionConstant::CARS_FINISHED;
        // }

        $item = $this->subscriptionManager->subscriptionIsActive($id);
        if ($item) { 

          return  $item['status'];
        } 

        return SubscriptionConstant::UNSUBSCRIBED;     
     }

    /**
     * This function is incomplete, it is used only to show the shape of the response,
     *  when the table of orders is complete, we will return to it.
     * check subscription , if time is finish or order count is finish, change status value to 'finished'
     * @throws NonUniqueResultException
     */
    public function checkValidityOfSubscription($storeOwner, $subscribeId)
    {
        $response = [];
        //Get full information for the current subscription
      
        // $remainingOrdersOfPackage = $this->subscriptionManager->getRemainingOrders($storeOwner, $subscribeId);
        $remainingOrdersOfPackage = [];
      
        // $countCarsBusy = $this->subscriptionManager->getCountCarsBusy($storeOwner, $subscribeId);
        $countCarsBusy = 5;
        // $remainingOrdersOfPackage['countCarsBusy'] = $countCarsBusy['countCarsBusy'];
        $remainingOrdersOfPackage['countCarsBusy'] = $countCarsBusy;

        // $countDeliveredOrder = $this->subscriptionManager->getCountDeliveredOrders($storeOwner, $subscribeId);

        // $remainingOrdersOfPackage['countOrdersDelivered'] = $countDeliveredOrder['countDeliveredOrders'];
        $remainingOrdersOfPackage['countOrdersDelivered'] = 5;
        $remainingOrdersOfPackage['subscriptionEndDate'] = null;
        if ($remainingOrdersOfPackage['subscriptionEndDate']) {
   
            $startDate = $remainingOrdersOfPackage['subscriptionStartDate'];
            $endDate = date_timestamp_get($remainingOrdersOfPackage['subscriptionEndDate']);
            $endDate1 = $remainingOrdersOfPackage['subscriptionEndDate'];
            
            $now = date_timestamp_get(new DateTime("now"));

            if ($endDate1->format('y-m-d') !== $startDate->format('y-m-d'))  {
               //Check subscription expiry date
                if ( $endDate <= $now )  {
        
                    $updateState = $this->updateSubscribeStateToFinish($remainingOrdersOfPackage['subscriptionId'], SubscriptionConstant::DATE_FINISHED);
                
                    if($updateState === SubscriptionConstant::UPDATE_STATE) {

                        if($this->getNextSubscription($storeOwner)) {

                            $this->changeIsFutureToFalse($this->getNextSubscription($storeOwner));

                            }

                        $response[] = [SubscriptionConstant::DATE_FINISHED];
                     }

                     $response[] = [SubscriptionConstant::ERROR];
                }

            if ($remainingOrdersOfPackage['remainingOrders'] === 0)  {
        
                $this->updateSubscribeStateToFinish($remainingOrdersOfPackage['subscriptionId'], SubscriptionConstant::ORDERS_FINISHED);
               
                if($updateState === SubscriptionConstant::UPDATE_STATE) {
               
                    if($this->getNextSubscription($storeOwner)) {
                
                        $this->changeIsFutureToFalse($this->getNextSubscription($storeOwner));
                    }
                
                    $response[] = [SubscriptionConstant::ORDERS_FINISHED];
                }

                $response[] = [SubscriptionConstant::ERROR];
            }
               
            if ((int)$remainingOrdersOfPackage['packageCarCount'] - (int)$countCarsBusy['countCarsBusy'] === 0)  {
               
                $remainingOrdersOfPackage['carsStatus']= SubscriptionConstant::CARS_FINISHED;
               
                $response[] = [SubscriptionConstant::CARS_FINISHED];   
            }
         }   
        }
         //this for tes only
         $remainingOrdersOfPackage['packageID'] = 1; 
         $remainingOrdersOfPackage['packageName'] = 'name'; 
         $remainingOrdersOfPackage['subscriptionId'] = $subscribeId; 
         $remainingOrdersOfPackage['remainingOrders'] = 5;
         $remainingOrdersOfPackage['packageCarCount'] = 5;
         $remainingOrdersOfPackage['packageOrderCount'] = 5;
         $remainingOrdersOfPackage['carsStatus'] = 5;

        $response = $this->autoMapping->map('array', RemainingOrdersResponse::class, $remainingOrdersOfPackage);
        
        $subscribeStatus = $this->subscriptionManager->subscriptionIsActive($subscribeId);
    
        if ($subscribeStatus['status']) {
            $response->subscriptionStatus = $subscribeStatus['status'];
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

    // public function getSubscriptionCurrent($storeOwner): ?array
    // {
    //     return $this->subscriptionManager->getSubscriptionCurrent($storeOwner);
    // }

    public function getNextSubscription($storeOwner)
    {
        return $this->subscriptionManager->getNextSubscription($storeOwner);
    }

    // public function packagebalance($storeOwner):mixed
    // {
    //     $response = SubscriptionConstant::UNSUBSCRIBED;

    //     $subscribe = $this->getSubscriptionCurrent($storeOwner);
        
    //     if ($subscribe) {

    //        return $this->checkValidityOfSubscription($storeOwner, $subscribe['id']);
    //     }

    //     return $response;
    // }

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
