<?php

namespace App\Service\Subscription;

use App\AutoMapping;
use App\Constant\Admin\Subscription\AdminStoreSubscriptionConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionEntity;
use App\Manager\Subscription\SubscriptionManager;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Request\Subscription\SubscriptionCreateRequest;
use App\Response\Subscription\SubscriptionResponse;
use App\Response\Subscription\MySubscriptionsResponse;
use App\Response\Subscription\RemainingOrdersResponse;
use App\Response\Subscription\CanCreateOrderResponse;
use App\Response\Subscription\SubscriptionExtendResponse;
use App\Response\Subscription\SubscriptionErrorResponse;
use App\Constant\Subscription\SubscriptionConstant;
use App\Constant\Subscription\SubscriptionCaptainOffer;
use App\Constant\Package\PackageConstant;
use App\Service\Subscription\SubscriptionCaptainOfferService;
use App\Service\StoreOwner\StoreOwnerProfileService;
use App\Service\StoreOwnerPayment\StoreOwnerPaymentService;
use App\Response\Subscription\StoreSubscriptionResponse;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\CaptainOfferConstant\CaptainOfferConstant;
use App\Request\Subscription\SubscriptionUpdateByAdminRequest;

class SubscriptionService
{
    private AutoMapping $autoMapping;
    private SubscriptionManager $subscriptionManager;
    private SubscriptionCaptainOfferService $subscriptionCaptainOfferService;
    private StoreOwnerProfileService $storeOwnerProfileService;
    private StoreOwnerPaymentService $storeOwnerPaymentService;

    public function __construct(AutoMapping $autoMapping, SubscriptionManager $subscriptionManager, SubscriptionCaptainOfferService $subscriptionCaptainOfferService, StoreOwnerProfileService $storeOwnerProfileService, StoreOwnerPaymentService $storeOwnerPaymentService)
    {
        $this->autoMapping = $autoMapping;
        $this->subscriptionManager = $subscriptionManager;
        $this->subscriptionCaptainOfferService = $subscriptionCaptainOfferService;
        $this->storeOwnerProfileService = $storeOwnerProfileService;
        $this->storeOwnerPaymentService = $storeOwnerPaymentService;
    }
    
    public function createSubscription(SubscriptionCreateRequest $request): SubscriptionResponse|SubscriptionErrorResponse
    {
        $isPackageReady = $this->isPackageReadyForSubscription($request->getPackage());
        if($isPackageReady->packageState === PackageConstant::PACKAGE_NOT_EXIST) {
        
            return $isPackageReady;
        }
        
        $activateExistingSubscription = $this->checkSubscription($request->getStoreOwner());

        $isFuture = $this->getIsFutureState($request->getStoreOwner());

        $request->setIsFuture($isFuture);
        $request->setHasExtra(SubscriptionConstant::IS_HAS_EXTRA_FALSE);
        $request->setType(SubscriptionConstant::POSSIBLE_TO_EXTRA_FALSE);

        $subscription = $this->subscriptionManager->createSubscription($request);

        //--check and update completeAccountStatus for the store owner profile

        if ($subscription) {
            $this->checkCompleteAccountStatusOfStoreOwnerProfile($subscription->getStoreOwner());
        }

        if ($activateExistingSubscription ===  SubscriptionConstant::NEW_SUBSCRIPTION_ACTIVATED) {
            $this->checkWhetherThereIsActiveCaptainsOfferAndUpdateSubscription($request->getStoreOwner()->getId());

            return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $subscription);

        }

        if($subscription) {
            $this->checkWhetherThereIsActiveCaptainsOfferAndUpdateSubscription($request->getStoreOwner()->getId());
        
            return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $subscription);
        }
    }

    public function getIsFutureState(int $storeOwner): int
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

           if($subscription['subscriptionCaptainOfferCarStatus'] === CaptainOfferConstant::STATUS_ACTIVE) {
              $subscription['packageCarCount'] += $subscription['subscriptionCaptainOfferCarCount'];
           }

           $subscription['canSubscriptionExtra'] = $this->canSubscriptionExtra($subscription["status"], $subscription["type"]);
           
           if($subscription['hasExtra'] === true) {

              $subscription['endDate'] =  new \DateTime($subscription['startDate']->format('Y-m-d h:i:s') . '1 day');
           }
           
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

    //$operationType : Increase the number of orders by 1 or decrease the number of orders by 1
    public function updateRemainingOrders(int $storeOwnerId, string $operationType): string
    {
        $subscriptionCurrent = $this->subscriptionManager->getSubscriptionCurrent($storeOwnerId);
        if($subscriptionCurrent) {
            if($subscriptionCurrent->getRemainingOrders() > 0) {
              //when create order
                if($operationType === SubscriptionConstant::OPERATION_TYPE_SUBTRACTION) {
                   $remainingOrders = $subscriptionCurrent->getRemainingOrders() - 1 ;
                } 
                //when cancel order
                if($operationType === SubscriptionConstant::OPERATION_TYPE_ADDITION) {
                   $remainingOrders = $subscriptionCurrent->getRemainingOrders() + 1 ;
                } 

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
            
            $endDate = $subscription['endDate'];
            
            if($subscription['hasExtra'] === SubscriptionConstant::IS_HAS_EXTRA_TRUE) {

                $endDate =  new \DateTime($subscription['startDate']->format('Y-m-d h:i:s') . '1 day');
            }
            
            //Is the subscription expired?
            if($endDate < $dateNow ) {
                //Is there extra time?
                // if($subscription['remainingTime'] > 0) {

                //   $subscription['endDate'] =  new \DateTime($subscription['endDate']->format('Y-m-d h:i:s') . $subscription['remainingTime'].'day');
                  //update end date and remainingTime and note
                //   $this->subscriptionManager->updateEndDate($subscription['id'], $subscription['endDate'], SubscriptionConstant::SUBSCRIPTION_EXTRA_TIME);

                //   return SubscriptionConstant::SUBSCRIPTION_OK;                
                // }

                return SubscriptionConstant::DATE_FINISHED;
            }
            
            return SubscriptionConstant::SUBSCRIPTION_OK;
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

           if($subscription['remainingCars'] >= 0 ) {
           
                $remainingCars =  $subscription['packageCarCount'] - $countOrders;
                
                //Is there subscription captain offer and active?
                if($subscription['subscriptionCaptainOfferId'] && $subscription['subscriptionCaptainOfferCarStatus'] === SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_ACTIVE) {
                   
                    $remainingCars = $this->captainOfferExpired($subscription, $remainingCars);
                }

                $currentSubscription = $this->subscriptionManager->updateRemainingCars($subscription['id'], $remainingCars);

                if($currentSubscription->getRemainingCars() <= 0 ) {
                
                    return SubscriptionConstant::CARS_FINISHED;
                }
            
                return SubscriptionConstant::SUBSCRIPTION_OK;
           }

          return SubscriptionConstant::CARS_FINISHED;
        }

        return SubscriptionConstant::YOU_DO_NOT_HAVE_SUBSCRIBED;
    }

    public function updateIsFutureAndSubscriptionCurrent(int $storeOwnerId): string
    {
        $subscription = $this->subscriptionManager->getSubscriptionForNextTime($storeOwnerId);
  
        if($subscription) {
             
           $this->subscriptionManager->updateIsFutureAndSubscriptionCurrent($subscription['id'], 0, SubscriptionConstant::IS_HAS_EXTRA_FALSE);
          
           return SubscriptionConstant::NEW_SUBSCRIPTION_ACTIVATED;
        }

        return SubscriptionConstant::UNSUBSCRIBED;
    }

    public function canCreateOrder(int $storeOwnerId): CanCreateOrderResponse|string
    {
        $storeStatus = $this->storeOwnerProfileService->checkStoreStatus($storeOwnerId);
        if($storeStatus === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS) {
            return $storeStatus;
        }

        $packageBalance = $this->packageBalance($storeOwnerId);
    
        if($packageBalance !== SubscriptionConstant::UNSUBSCRIBED) {

            $item['subscriptionStatus'] = $packageBalance->status;

            if($packageBalance->status ===  SubscriptionConstant::SUBSCRIBE_ACTIVE) {
            
            $item['canCreateOrder'] = SubscriptionConstant::CAN_CREATE_ORDER;
            }
            else{
    
            $item['canCreateOrder'] = SubscriptionConstant::CAN_NOT_CREATE_ORDER;
            }
            
            $item['percentageOfOrdersConsumed'] = $this->getPercentageOfOrdersConsumed($packageBalance->packageOrderCount, $packageBalance->remainingOrders);
            $item['packageName'] = $packageBalance->packageName;
            
            return $this->autoMapping->map("array", CanCreateOrderResponse::class, $item);
        }

        $item['subscriptionStatus'] = SubscriptionConstant::UNSUBSCRIBED;
        $item['canCreateOrder'] = SubscriptionConstant::CAN_NOT_CREATE_ORDER;

        return $this->autoMapping->map("array", CanCreateOrderResponse::class, $item);
    }
    
    public function subscriptionForOneDay(int $storeOwnerId): SubscriptionExtendResponse|SubscriptionResponse|SubscriptionErrorResponse
    {
        $subscriptionCurrent = $this->subscriptionManager->getSubscriptionCurrentWithRelation($storeOwnerId);
            if($subscriptionCurrent) {
            
                $isPackageReady = $this->isPackageReadyForSubscription($subscriptionCurrent['packageId']);
                if($isPackageReady->packageState === PackageConstant::PACKAGE_NOT_EXIST) {
                
                    return $isPackageReady;
                }

                if($subscriptionCurrent['type'] === false) {

                    if($subscriptionCurrent['status'] !== "active" && $subscriptionCurrent['status'] !== "inactive") {
                        
                        return $this->createSubscriptionForOneDay($subscriptionCurrent, $storeOwnerId);
                    }

                    $subscription['state'] = SubscriptionConstant::YOU_HAVE_SUBSCRIBED;

                    return $this->autoMapping->map("array", SubscriptionExtendResponse::class, $subscription);
                }

                $subscription['state'] = SubscriptionConstant::NOT_POSSIBLE;

                return $this->autoMapping->map("array", SubscriptionExtendResponse::class, $subscription);
        }

        $subscription['state'] = SubscriptionConstant::YOU_DO_NOT_HAVE_SUBSCRIBED;
           
        return $this->autoMapping->map("array", SubscriptionExtendResponse::class, $subscription); 
    }

    public function createSubscriptionForOneDay(array $subscriptionCurrent, int $storeOwnerId): ?SubscriptionResponse 
    {
        $request = new SubscriptionCreateRequest();

        $request->setStoreOwner($storeOwnerId);
        $request->setPackage($subscriptionCurrent['packageId']);
        $request->setIsFuture(SubscriptionConstant::IS_FUTURE_FALSE);
        $request->setHasExtra(SubscriptionConstant::IS_HAS_EXTRA_TRUE);
        $request->setType(SubscriptionConstant::POSSIBLE_TO_EXTRA_TRUE);

        $subscription = $this->subscriptionManager->createSubscription($request);
                
        return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $subscription);
    }

    /**
     * @param string $status
     * @param bool|null $type
     * @return bool|null
     */
    public function canSubscriptionExtra(string $status, $type): bool|null
    {
      if($type === SubscriptionConstant::POSSIBLE_TO_EXTRA_TRUE) {
        return SubscriptionConstant::CAN_SUBSCRIPTION_EXTRA_FALSE; 
      }

      if($type === SubscriptionConstant::POSSIBLE_TO_EXTRA_FALSE) {
        if($status === SubscriptionConstant::ORDERS_FINISHED || $status === SubscriptionConstant::DATE_FINISHED) {
           return SubscriptionConstant::CAN_SUBSCRIPTION_EXTRA_TRUE;
        }

        return SubscriptionConstant::CAN_SUBSCRIPTION_EXTRA_FALSE;
      }
      
      return SubscriptionConstant::CAN_SUBSCRIPTION_EXTRA_FALSE;
    }

    public function isPackageReadyForSubscription(int $packageId): SubscriptionErrorResponse
    {
        $package = $this->subscriptionManager->isPackageReadyForSubscription($packageId);
        if(!$package ) {
         
            $package['packageState'] = PackageConstant::PACKAGE_NOT_EXIST;
         }

        else {

            $package['packageState'] = PackageConstant::PACKAGE_EXIST;
        }
        
         return $this->autoMapping->map("array", SubscriptionErrorResponse::class, $package);
    }
    
    public function captainOfferExpired(null|array|SubscriptionEntity $subscription, int $remainingCars): int
    {    
        if($subscription) {
           
            $dateNow = new \DateTime('now');
            $endSubscriptionCaptainOffer = $subscription['subscriptionCaptainOfferExpired'].'day';

            $endDate =  new \DateTime($subscription['subscriptionCaptainOfferStartDate']->format('Y-m-d h:i:s') . $endSubscriptionCaptainOffer);

            if($endDate < $dateNow) {

                $remainingCars = $subscription['remainingCars'] - $subscription['subscriptionCaptainOfferCarCount'];
            
                $this->subscriptionCaptainOfferService->updateState($subscription['subscriptionCaptainOfferId'],  SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_INACTIVE);

                return $remainingCars;
            }

            $remainingCars = $remainingCars + $subscription['subscriptionCaptainOfferCarCount'];

            return $remainingCars;
        }

        return SubscriptionConstant::YOU_DO_NOT_HAVE_SUBSCRIBED;
    }

    /**
     * This function checks completeAccountStatus of the store owner profile and updates it when necessary
     */
    public function checkCompleteAccountStatusOfStoreOwnerProfile(StoreOwnerProfileEntity $storeOwner)
    {
        // First, check if there is a subscription
        $subscriptionHistory = $this->subscriptionManager->getSubscriptionHistoryByStoreOwner($storeOwner);

        if ($subscriptionHistory != null) {
            // subscription is exist, then check completeAccountStatus field.
            $storeOwnerProfileResult = $this->subscriptionManager->getStoreOwnerProfileByStoreOwnerId($storeOwner->getStoreOwnerId());

            if ($storeOwnerProfileResult) {
                if ($storeOwnerProfileResult->getCompleteAccountStatus() === StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED ||
                    $storeOwnerProfileResult->getCompleteAccountStatus() === StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_VERIFIED ||
                    $storeOwnerProfileResult->getCompleteAccountStatus() === StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_COMPLETED) {
                    // then we can update completeAccountStatus to subscriptionCreated

                    $completeAccountStatusUpdateRequest = new CompleteAccountStatusUpdateRequest();

                    $completeAccountStatusUpdateRequest->setUserId($storeOwner->getStoreOwnerId());
                    $completeAccountStatusUpdateRequest->setCompleteAccountStatus(StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_SUBSCRIPTION_CREATED);

                    $this->subscriptionManager->storeOwnerProfileCompleteAccountStatusUpdate($completeAccountStatusUpdateRequest);
                }
            }
        }
    }

    public function checkRemainingCarsByOrderId(int $orderId): string
    {
      $subscription = $this->subscriptionManager->getSubscriptionCurrentByOrderId($orderId);

      return $this->checkRemainingCars($subscription);
    }

    public function checkWhetherThereIsActiveCaptainsOfferAndUpdateSubscription(int $storeOwnerId): string
    {
      $captainOfferId = $this->subscriptionManager->checkWhetherThereIsActiveCaptainsOffer($storeOwnerId);

      if($captainOfferId) {
        return $this->subscriptionManager->updateSubscriptionCaptainOfferId($captainOfferId->getSubscriptionCaptainOffer());
      }
       
      return SubscriptionCaptainOffer::YOU_DO_NOT_HAVE_SUBSCRIBED_CAPTAIN_OFFER; 
    }

    public function getPercentageOfOrdersConsumed(int $packageOrderCount, int $remainingOrders): string|null
    {
        $sub = $packageOrderCount -  $remainingOrders;
        
        $percentage = ( $sub / $packageOrderCount ) * 100;
         
        return $percentage . SubscriptionConstant::PERCENT ;
    }
    
    // public function getPercentageOfOrdersConsumed(int $packageOrderCount, int $remainingOrders): string|null
    // {
    //     if($remainingOrders === 0) {
            // return SubscriptionConstant::CONSUMED_100_PERCENT ;
    //     }

    //     if($remainingOrders === (100 * $packageOrderCount) / 100) {
    //         return SubscriptionConstant::CONSUMED_0_PERCENT ;
    //     }
         
    //     if($remainingOrders <= (20 * $packageOrderCount) / 100 && $remainingOrders >= (1 * $packageOrderCount) / 100) {
    //         return SubscriptionConstant::CONSUMED_LESS_THAN_20_PERCENT ;
    //     } 

    //     if($remainingOrders <= (50 * $packageOrderCount) / 100 && $remainingOrders >= (21 * $packageOrderCount) / 100) {
    //         return SubscriptionConstant::CONSUMED_LESS_THAN_50_PERCENT ;
    //     }

    //     if($remainingOrders <= (80 * $packageOrderCount) / 100 && $remainingOrders >= (51 * $packageOrderCount) / 100) {
    //         return SubscriptionConstant::CONSUMED_LESS_THAN_80_PERCENT ;
    //     }

    //     if($remainingOrders <= (99 * $packageOrderCount) / 100 && $remainingOrders >= (81 * $packageOrderCount) / 100) {
    //         return SubscriptionConstant::CONSUMED_MORE_THAN_80_PERCENT ;
    //     }
        
    //     return null;
    // }

    public function getStoreOwnerProfileStatus(int $storeOwnerId): string
    {
        return $this->storeOwnerProfileService->checkStoreStatus($storeOwnerId);
    }
    
    public function getSubscriptionsWithPayments(int $userId): array
    {
       $response = [];

       $subscriptions = $this->subscriptionManager->getSubscriptionsByUserID($userId);

       foreach ($subscriptions as $subscription) {

            $subscription['paymentsFromStore'] = $this->storeOwnerPaymentService->getStorePaymentsBySubscriptionId($subscription['id']);
          
            $subscription['captainOffers'] = $this->subscriptionManager->getCaptainOffersBySubscriptionId($subscription['id']);

            $subscription['total'] = $this->getTotal($subscription['paymentsFromStore'], $subscription['packageCost'], $subscription['captainOffers']);
         
            $response[] = $this->autoMapping->map("array", StoreSubscriptionResponse::class, $subscription);
        }

        return $response;
    }
    
    public function getTotal(array $payments, float $packageCost, array $captainOffers): array
    {
        $item['sumPayments'] = array_sum(array_map(fn ($payment) => $payment->amount, $payments));
        $sumCaptainOfferPrices = array_sum(array_map(fn ($captainOffer) => $captainOffer['price'], $captainOffers));
      
        $item['captainOfferPrice'] = $sumCaptainOfferPrices;

        $item['packageCost'] = $packageCost;
      
        $item['requiredToPay'] = $packageCost + $sumCaptainOfferPrices;
      
        $total = $item['sumPayments'] - ($packageCost + $sumCaptainOfferPrices);
       
        $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;
    
        if($total <= 0 ) {
            $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;    
        }

        $item['total'] = abs($total);
        
        return  $item;
    }
     
    public function updateSubscription(SubscriptionUpdateByAdminRequest $request)
    {
        return $this->subscriptionManager->updateSubscription($request);
    }

    public function packageBalanceForAdminByStoreOwnerProfileId(int $storeOwnerProfileId): array
    {
        $store = $this->subscriptionManager->getStoreOwnerProfileByStoreOwnerProfileId($storeOwnerProfileId);

        $packageBalance = $this->packageBalance($store->getStoreOwnerId());

        $balance = [];
        $balance['remainingOrders'] = 0;
        $balance['remainingCars'] = 0;
        
        if($packageBalance->status !== SubscriptionConstant::UNSUBSCRIBED) {
            $balance['remainingOrders'] = $packageBalance->remainingOrders;
            $balance['remainingCars'] = $packageBalance->remainingCars;
        }

        return $balance;
    }

    public function checkIfStoreSubscriptionsHavePayments(int $storeOwnerId): int
    {
        $storeSubscriptions = $this->subscriptionManager->getAllSubscriptionsEntitiesByStoreOwnerId($storeOwnerId);

        if (! empty($storeSubscriptions)) {
            foreach ($storeSubscriptions as $storeSubscription) {
                if (! empty($storeSubscription->getStoreOwnerPaymentEntities()->toArray())) {
                    // return can not delete subscriptions because payments related to it are exists
                    return AdminStoreSubscriptionConstant::STORE_SUBSCRIPTION_HAS_PAYMENTS;
                }
            }
        }

        return AdminStoreSubscriptionConstant::STORE_SUBSCRIPTION_HAS_NOT_ANY_PAYMENTS;
    }

    public function deleteStoreSubscriptionByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->subscriptionManager->deleteStoreSubscriptionByStoreOwnerId($storeOwnerId);
    }

    public function createSubscriptionByAdmin(SubscriptionCreateRequest $request ,int $storeOwnerProfileId): SubscriptionResponse|SubscriptionErrorResponse|string|int
    {  
        $store = $this->subscriptionManager->getStoreOwnerProfileByStoreOwnerProfileId($storeOwnerProfileId);
        if (! $store) {
            return StoreProfileConstant::STORE_NOT_FOUND;
        }
       
        $request->setStoreOwner($store->getStoreOwnerId());

        return $this->createSubscription($request);
    }

    public function extraSubscriptionForDayByAdmin(int $storeOwnerProfileId): SubscriptionExtendResponse|SubscriptionResponse|SubscriptionErrorResponse|int
    {  
        $store = $this->subscriptionManager->getStoreOwnerProfileByStoreOwnerProfileId($storeOwnerProfileId);
        if (! $store) {
            return StoreProfileConstant::STORE_NOT_FOUND;
        }
       
        return $this->subscriptionForOneDay($store->getStoreOwnerId());
    }

    public function getSubscriptionEntityById(int $subscriptionId): ?SubscriptionEntity
    {
        return $this->subscriptionManager->getSubscriptionById($subscriptionId);
    }

    public function updateSubscriptionByRemovingCaptainOfferSubscription(int $subscriptionId): ?SubscriptionEntity
    {
        return $this->subscriptionManager->updateSubscriptionByRemovingCaptainOfferSubscription($subscriptionId);
    }
}
 
