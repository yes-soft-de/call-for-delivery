<?php

namespace App\Service\Subscription;

use App\AutoMapping;
use App\Constant\Notification\SubscriptionFirebaseNotificationConstant;
use App\Constant\Order\OrderCostDefaultValueConstant;
use App\Constant\Order\OrderResultConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\StoreOwnerPreference\StoreOwnerPreferenceConstant;
use App\Constant\Subscription\SubscriptionDetailsConstant;
use App\Constant\Subscription\SubscriptionFlagConstant;
use App\Entity\PackageEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionDetailsEntity;
use App\Entity\SubscriptionEntity;
use App\Manager\Subscription\SubscriptionManager;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Request\Subscription\SubscriptionCreateRequest;
use App\Response\Subscription\CurrentStoreSubscriptionBalanceGetResponse;
use App\Response\Subscription\SubscriptionResponse;
use App\Response\Subscription\MySubscriptionsResponse;
use App\Response\Subscription\RemainingOrdersResponse;
use App\Response\Subscription\CanCreateOrderResponse;
use App\Response\Subscription\SubscriptionExtendResponse;
use App\Response\Subscription\SubscriptionErrorResponse;
use App\Constant\Subscription\SubscriptionConstant;
use App\Constant\Subscription\SubscriptionCaptainOffer;
use App\Constant\Package\PackageConstant;
use App\Service\Notification\SubscriptionFirebaseNotificationService;
use App\Service\StoreOwner\StoreOwnerProfileService;
use App\Service\StoreOwnerDuesFromCashOrders\StoreOwnerDueFromCashOrderGetService;
use App\Service\StoreOwnerPayment\StoreOwnerPaymentService;
use App\Response\Subscription\StoreSubscriptionResponse;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\CaptainOfferConstant\CaptainOfferConstant;
use App\Request\Subscription\SubscriptionUpdateByAdminRequest;
use App\Request\Subscription\CalculateCostDeliveryOrderRequest;
use App\Response\Subscription\CalculateCostDeliveryOrderResponse;
use App\Request\Admin\Subscription\AdminCalculateCostDeliveryOrderRequest;
use DateTimeInterface;

class SubscriptionService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private SubscriptionManager $subscriptionManager,
        private SubscriptionCaptainOfferService $subscriptionCaptainOfferService,
        private StoreOwnerProfileService $storeOwnerProfileService,
        private StoreOwnerPaymentService $storeOwnerPaymentService,
        private SubscriptionNotificationService $subscriptionNotificationService,
        private SubscriptionFirebaseNotificationService $subscriptionFirebaseNotificationService,
        private SubscriptionDetailsService $subscriptionDetailsService,
        private StoreSubscriptionCheckService $storeSubscriptionCheckService,
        private StoreOwnerDueFromCashOrderGetService $storeOwnerDueFromCashOrderGetService
    )
    {
    }
    
    public function createSubscription(SubscriptionCreateRequest $request): SubscriptionResponse|SubscriptionErrorResponse
    {
        $isPackageReady = $this->isPackageReadyForSubscription($request->getPackage());

        if ($isPackageReady->packageState === PackageConstant::PACKAGE_NOT_EXIST) {
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

            // Send firebase notification to admin
            $this->sendFirebaseNotificationToAdmin(SubscriptionFirebaseNotificationConstant::STORE_CREATE_NEW_SUBSCRIPTION_CONST,
                $subscription->getStoreOwner()->getStoreOwnerName(), null);
        
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

        if ($subscription) {
            if ($subscription['subscriptionCaptainOfferCarStatus'] === CaptainOfferConstant::STATUS_ACTIVE) {
                $subscription['packageCarCount'] += $subscription['subscriptionCaptainOfferCarCount'];
            }

            $subscription['canSubscriptionExtra'] = $this->canSubscriptionExtra($subscription["status"], $subscription["type"]);

            if ($subscription['hasExtra'] === true) {
                $subscription['endDate'] = new \DateTime($subscription['startDate']->format('Y-m-d h:i:s') . '1 day');
            }

            // get the sum of unpaid cash orders
            $subscription['unPaidCashOrdersSum'] = $this->getUnPaidStoreOwnerDuesFromCashOrderSumByStoreSubscriptionId($subscription['id']);

            return $this->autoMapping->map("array", RemainingOrdersResponse::class, $subscription);
        }

        $subscription['status'] = SubscriptionConstant::UNSUBSCRIBED;

        return $this->autoMapping->map("array", RemainingOrdersResponse::class, $subscription);
    }

    public function checkSubscription(int $storeOwnerId): string
    {
       $checkSubscription = $this->checkValidityOfSubscription($storeOwnerId);
      
       if($checkSubscription === SubscriptionConstant::UNSUBSCRIBED
           || $checkSubscription === SubscriptionConstant::ORDERS_FINISHED
           || $checkSubscription === SubscriptionConstant::DATE_FINISHED) {

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

                $storeDetailsEntity = $this->subscriptionManager->updateRemainingOrders($subscriptionCurrent->getLastSubscription()->getId(), $remainingOrders);

                // send firebase notification to admin if new value of the remaining orders less than zero
                if ($storeDetailsEntity !== SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND) {
                    $this->checkRemainingOrdersOfStoreSubscriptionAndInformAdmin($storeDetailsEntity->getRemainingOrders(),
                        $storeOwnerId);
                }

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

            // save current remaining cars for sending notification to store or not
            $currentRemainingCars = $subscription['remainingCars'];

           if($subscription['remainingCars'] >= 0 ) {

               $remainingCars = $subscription['packageCarCount'] - $countOrders;

               //Is there subscription captain offer and active?
               if ($subscription['subscriptionCaptainOfferId'] && $subscription['subscriptionCaptainOfferCarStatus'] === SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_ACTIVE) {

                   $remainingCars = $this->captainOfferExpired($subscription, $remainingCars);
               }

               // save new remaining cars for sending notification to store or not
               $newRemainingCars = $remainingCars;

               $currentSubscription = $this->subscriptionManager->updateRemainingCars($subscription['id'], $remainingCars);

               // Check remaining cars if it has a negative, and inform admin if it is
               if ($currentSubscription) {
                   $this->checkRemainingCarsOfStoreSubscriptionAndInformAdmin($currentSubscription->getRemainingCars(),
                       $currentSubscription->getStoreOwner()->getStoreOwnerName());
               }

               // Now check if we have to inform the store there is new available car/s or not
               $this->checkRemainingCarsAndInformStore($currentRemainingCars, $newRemainingCars, $subscription);

               if ($currentSubscription->getRemainingCars() <= 0) {

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

        if ($storeStatus === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS) {
            return $storeStatus;
        }

        $packageBalance = $this->packageBalance($storeOwnerId);
    
        if ($packageBalance->status !== SubscriptionConstant::UNSUBSCRIBED) {
            if ($packageBalance->status === SubscriptionConstant::ORDERS_FINISHED) {
                if (($packageBalance->packageId === 18)) {
                    // new subscription system.
                    // while the free subscription it is over then update it automatically
                    $createSubscriptionRequest = new SubscriptionCreateRequest();

                    $createSubscriptionRequest->setStoreOwner($storeOwnerId);
                    $createSubscriptionRequest->setPackage(19);

                    $createSubscriptionResult = $this->createSubscription($createSubscriptionRequest);

                    if ($createSubscriptionResult) {
                        if ($createSubscriptionResult instanceof SubscriptionResponse) {
                            // subscription created successfully
                            $item['subscriptionStatus'] = $createSubscriptionResult->status;

                            $packageBalance = $this->packageBalance($storeOwnerId);

                            $item['percentageOfOrdersConsumed'] = $this->getPercentageOfOrdersConsumed($packageBalance->packageOrderCount,
                                $packageBalance->remainingOrders);

                            $item['packageName'] = $packageBalance->packageName;
                            $item['packageType'] = $packageBalance->packageType;
                            $item['firstTimeSubscriptionWithUniformPackage'] = true;

                            return $this->autoMapping->map("array", CanCreateOrderResponse::class, $item);
                        }
                    }
                }

            } elseif ($packageBalance->status === SubscriptionConstant::SUBSCRIBE_ACTIVE) {
                if ($packageBalance->packageId === 19) {
                    // check how much does store make orders
                    $ordersCostSum = $this->checkDeliveredOrdersCostTillNow($storeOwnerId, $packageBalance->id);

                    $subscriptionCostLimit = OrderCostDefaultValueConstant::ORDER_COST_LIMIT_CONST;

                    $storeSubscriptionCostLimit = $this->getStoreOwnerPreferenceSubscriptionCostLimitByStoreOwnerUserId($storeOwnerId);

                    if ($storeSubscriptionCostLimit) {
                        if (($storeSubscriptionCostLimit !== StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS)
                            && ($storeSubscriptionCostLimit !== StoreOwnerPreferenceConstant::STORE_OWNER_PREFERENCE_NOT_EXIST_CONST)) {
                            $subscriptionCostLimit = $storeSubscriptionCostLimit;
                        }
                    }//dd($ordersCostSum, $subscriptionCostLimit);

                    if ($ordersCostSum >= $subscriptionCostLimit) {
                        // de-activate the subscription till the store make the required payment
                        $subscriptionUpdateResult = $this->deActivateCurrentSubscriptionByStoreOwnerUserId($storeOwnerId);

                        if ($subscriptionUpdateResult !== SubscriptionConstant::SUBSCRIPTION_NOT_FOUND) {
                            // re-check balance after ending subscription
                            $packageBalance = $this->packageBalance($storeOwnerId);

                            $item['hasToPay'] = true;
                        }
                    }
                }

            } elseif ($packageBalance->status === SubscriptionConstant::DATE_FINISHED) {
                if ($packageBalance->packageId === 19) {
                    // check how much does store make orders
                    $ordersCostSum = $this->checkDeliveredOrdersCostTillNow($storeOwnerId, $packageBalance->id);

                    $subscriptionCostLimit = OrderCostDefaultValueConstant::ORDER_COST_LIMIT_CONST;

                    $storeSubscriptionCostLimit = $this->getStoreOwnerPreferenceSubscriptionCostLimitByStoreOwnerUserId($storeOwnerId);

                    if ($storeSubscriptionCostLimit) {
                        if (($storeSubscriptionCostLimit !== StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS)
                            && ($storeSubscriptionCostLimit !== StoreOwnerPreferenceConstant::STORE_OWNER_PREFERENCE_NOT_EXIST_CONST)) {
                            $subscriptionCostLimit = $storeSubscriptionCostLimit;
                        }
                    }

                    if ($ordersCostSum >= $subscriptionCostLimit) {
                        // re-check balance after ending subscription
                        $packageBalance = $this->packageBalance($storeOwnerId);

                        $item['hasToPay'] = true;
                    }
                }
            }

            $item['subscriptionStatus'] = $packageBalance->status;
            // if subscription active
            if ($packageBalance->status === SubscriptionConstant::SUBSCRIBE_ACTIVE) {
                $item['canCreateOrder'] = SubscriptionConstant::CAN_CREATE_ORDER;

            } elseif ($packageBalance->status === SubscriptionConstant::CARS_FINISHED) {
                // if subscription cars finished
                $item['canCreateOrder'] = SubscriptionConstant::CARS_FINISHED;
            }

            else {
                $item['canCreateOrder'] = SubscriptionConstant::CAN_NOT_CREATE_ORDER;
            }
            
            $item['percentageOfOrdersConsumed'] = $this->getPercentageOfOrdersConsumed($packageBalance->packageOrderCount, $packageBalance->remainingOrders);

            $item['packageName'] = $packageBalance->packageName;
            $item['packageType'] = $packageBalance->packageType;

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
                        
                        $result = $this->createSubscriptionForOneDay($subscriptionCurrent, $storeOwnerId);

                        // Send firebase notification to admin
                        if ($result) {
                            $this->sendFirebaseNotificationToAdmin(SubscriptionFirebaseNotificationConstant::STORE_CREATE_NEW_SUBSCRIPTION_FOR_ONE_DAY_CONST,
                                null, $storeOwnerId);
                        }

                        return $result;
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

    /**
     * Check if there is captain offer subscription linked with a previous store subscription,
     * And if it exists, and active, then link it with the new current store subscription
     */
    public function checkWhetherThereIsActiveCaptainsOfferAndUpdateSubscription(int $storeOwnerId): string
    {
      $captainOfferId = $this->subscriptionManager->checkWhetherThereIsActiveCaptainsOffer($storeOwnerId);

      if($captainOfferId) {
        $arrayResult = $this->subscriptionManager->updateSubscriptionCaptainOfferId($captainOfferId->getSubscriptionCaptainOffer());

        if ($arrayResult === SubscriptionConstant::ERROR) {
            return SubscriptionConstant::ERROR;

        } else {
            // the result is of type array
            $subscriptionDetailsEntity = $arrayResult[1];

            // Check if remaining cars has negative value, and inform the admin if it is
            if ($subscriptionDetailsEntity) {
                $this->checkRemainingCarsOfStoreSubscriptionAndInformAdmin($subscriptionDetailsEntity->getRemainingCars(),
                    $subscriptionDetailsEntity->getStoreOwner()->getStoreOwnerName());
            }

            return $arrayResult[0];
        }
      }
       
      return SubscriptionCaptainOffer::YOU_DO_NOT_HAVE_SUBSCRIBED_CAPTAIN_OFFER; 
    }

    public function getPercentageOfOrdersConsumed(int $packageOrderCount, int $remainingOrders): string|null
    {
        $sub = $packageOrderCount -  $remainingOrders;
        
        $percentage = ( $sub / $packageOrderCount ) * 100;
         
        return $percentage . SubscriptionConstant::PERCENT ;
    }

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
            $subscription['ordersExceedGeographicalRange'] = $this->getOrdersExceedGeographicalRangeBySubscriptionIdAndGeographicalRange($subscription['id'], (float)$subscription['packageGeographicalRange']);
            $totalExtraDistance = $this->getTotalExtraDistance($subscription['ordersExceedGeographicalRange'], (float)$subscription['packageGeographicalRange']);
           
            //if package is on order
            if ($subscription['packageType'] === PackageConstant::PACKAGE_TYPE_ON_ORDER) {
                $subscription['total'] = $this->getTotalWithPackageOnOrder($subscription['paymentsFromStore'], $subscription['packageCost'], $subscription['captainOffers'], (float)$subscription['packageExtraCost'], $totalExtraDistance, $subscription['id']);
            }
            else {
               
                $subscription['total'] = $this->getTotal($subscription['paymentsFromStore'], $subscription['packageCost'], $subscription['captainOffers'],(float)$subscription['packageExtraCost'], $totalExtraDistance);
            }

            $response[] = $this->autoMapping->map("array", StoreSubscriptionResponse::class, $subscription);
        }

        return $response;
    }

    //Get the cost of regular subscriptions 
    public function getTotal(array $payments, float $packageCost, array $captainOffers, float $packageExtraCost, int $totalDistanceExtra): array
    {
        $item['totalDistanceExtra'] = $totalDistanceExtra;
        $item['packageCost'] = $packageCost;
        $item['sumPayments'] = array_sum(array_map(fn ($payment) => $payment->amount, $payments));
        $sumCaptainOfferPrices = 0;

        // $sumCaptainOfferPrices = array_sum(array_map(fn ($captainOffer) => $captainOffer['price'], $captainOffers));
       
        foreach($captainOffers as $captainOffer) {
            if($captainOffer['captainOfferFirstTime'] === true) {
                $sumCaptainOfferPrices += $captainOffer['price'];
            }
        }

        $item['extraCost'] = $packageExtraCost * $item['totalDistanceExtra'];
       
        $item['captainOfferPrice'] = $sumCaptainOfferPrices;

        $item['packageCost'] = $packageCost;
      
        $item['requiredToPay'] = $packageCost + $sumCaptainOfferPrices + $item['extraCost'];
      
        $total = $item['sumPayments'] - $item['requiredToPay'];

        $item['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_NOT_EXIST_CONST;

        if ($total > 0) {
            $item['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_EXIST_CONST;

        } elseif ($total == 0) {
            $item['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_BALANCE_CONST;
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

//    public function checkIfStoreSubscriptionsHavePayments(int $storeOwnerId): int
//    {
//        $storeSubscriptions = $this->subscriptionManager->getAllSubscriptionsEntitiesByStoreOwnerId($storeOwnerId);
//
//        if (! empty($storeSubscriptions)) {
//            foreach ($storeSubscriptions as $storeSubscription) {
//                if (! empty($storeSubscription->getStoreOwnerPaymentEntities()->toArray())) {
//                    // return can not delete subscriptions because payments related to it are exists
//                    return AdminStoreSubscriptionConstant::STORE_SUBSCRIPTION_HAS_PAYMENTS;
//                }
//            }
//        }
//
//        return AdminStoreSubscriptionConstant::STORE_SUBSCRIPTION_HAS_NOT_ANY_PAYMENTS;
//    }

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

    //Calculate Cost Delivery Order
    public function calculateCostDeliveryOrder(CalculateCostDeliveryOrderRequest $request):CalculateCostDeliveryOrderResponse
    {
        $item = [];
        $item['extraDistance'] = 0;
        $item['orderDeliveryCost'] = 0;
        $item['extraOrderDeliveryCost'] = 0;

        $subscription = $this->subscriptionManager->getSubscriptionCurrentWithRelation($request->getStoreOwner());

        if ($subscription) {
            if (($subscription['packageId'] === 18) || ($subscription['packageId'] === 19)) {
                if ($subscription['openingOrderCost']) {
                    $item['orderDeliveryCost'] = $subscription['openingOrderCost'];

                } else {
                    $item['orderDeliveryCost'] = 14;
                }

                if ($subscription['oneKilometerCost']) {
                    $item['extraOrderDeliveryCost'] = $request->getStoreBranchToClientDistance() * $subscription['oneKilometerCost'];

                } else {
                    $item['extraOrderDeliveryCost'] = $request->getStoreBranchToClientDistance() * 1;
                }

                $item['total'] = $item['orderDeliveryCost'] + $item['extraOrderDeliveryCost'];

            } else {
                $item['extraDistance'] = $this->getExtraDistance($subscription['geographicalRange'], $request->getStoreBranchToClientDistance());

                if ($subscription['packageType'] === PackageConstant::PACKAGE_TYPE_ON_ORDER) {
                    $item['orderDeliveryCost'] = $subscription['packageCost'];

                } else {
                    $item['orderDeliveryCost'] = round($subscription['packageCost'] / $subscription['packageOrderCount'], 2);
                }

                $item['extraOrderDeliveryCost'] = ($item['extraDistance'] * $subscription['packageExtraCost']);

                $item['total'] = $item['orderDeliveryCost'] + $item['extraOrderDeliveryCost'];
            }
        }
     
        return $this->autoMapping->map("array", CalculateCostDeliveryOrderResponse::class, $item);
    }

    //Get Extra Distance
    public function getExtraDistance(float|null $geographicalRange, float $storeBranchToClientDistance)
    {
        $extraDistance = 0;

        if(!$geographicalRange) {
            return $extraDistance;
        }

        if( $storeBranchToClientDistance > $geographicalRange) {
            $extraDistance = $storeBranchToClientDistance - $geographicalRange;
        }

        return $extraDistance;
    }

     //Calculate Cost Delivery Order for admin
     public function calculateCostDeliveryOrderForAdmin(AdminCalculateCostDeliveryOrderRequest $adminRequest):CalculateCostDeliveryOrderResponse
     {
        $store = $this->subscriptionManager->getStoreOwnerProfileByStoreOwnerProfileId($adminRequest->getStoreOwnerProfileId());
      
        $request = new CalculateCostDeliveryOrderRequest();
        
        $request->setStoreOwner($store->getStoreOwnerId());
        $request->setStoreBranchToClientDistance($adminRequest->getStoreBranchToClientDistance());
       
        return $this->calculateCostDeliveryOrder($request);
     }

    //Get the cost of subscriptions on order
    public function getTotalWithPackageOnOrder(array $payments, float $packageCost, array $captainOffers, float $packageExtraCost, float $totalExtraDistance, int $subscriptionId)
    {
        $item['totalDistanceExtra'] = $totalExtraDistance;
        $item['packageCost'] = $packageCost;
        //consumed orders from the package
        $item['countOfConsumedOrders'] = $this->subscriptionManager->getCountOfConsumedOrders($subscriptionId);

        $sumCaptainOfferPrices = 0;
        
        $item['sumPayments'] = array_sum(array_map(fn ($payment) => $payment->amount, $payments));
      
        foreach($captainOffers as $captainOffer) {
            if($captainOffer['captainOfferFirstTime'] === true) {
                $sumCaptainOfferPrices += $captainOffer['price'];
            }
        }

        $item['extraCost'] = $packageExtraCost * $item['totalDistanceExtra'];
       
        $item['captainOfferPrice'] = $sumCaptainOfferPrices;

        $item['packageCost'] = $packageCost;
      
        $item['requiredToPay'] = ($packageCost * $item['countOfConsumedOrders']) + $sumCaptainOfferPrices + $item['extraCost'];
      
        $total = $item['sumPayments'] - $item['requiredToPay'];

        $item['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_NOT_EXIST_CONST;

        if ($total > 0) {
            $item['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_EXIST_CONST;

        } elseif ($total == 0) {
            $item['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_BALANCE_CONST;
        }

        $item['total'] = abs($total);
        
        return  $item;
    }

    //get total extra distance for subscription
    public function getTotalExtraDistance(array $orders, float $packageGeographicalRange): float
    {
        $totalDistanceExtra = 0;

        foreach($orders as $order) {
            $distance = $this->getExtraDistance($packageGeographicalRange, $order['storeBranchToClientDistance']);

            $totalDistanceExtra += $distance;
        }

        return  $totalDistanceExtra;    
    }

    //get Orders Exceed Geographical Range
    public function getOrdersExceedGeographicalRangeBySubscriptionIdAndGeographicalRange(int $subscriptionId, float $packageGeographicalRange):array
    {
        return $this->subscriptionManager->getOrdersExceedGeographicalRangeBySubscriptionId($subscriptionId, $packageGeographicalRange);
    }

    public function createNewSubscriptionForSamePackageByAdmin(SubscriptionCreateRequest $request ,int $storeOwnerProfileId): SubscriptionResponse|SubscriptionErrorResponse|string|int
    {
        $store = $this->subscriptionManager->getStoreOwnerProfileByStoreOwnerProfileId($storeOwnerProfileId);

        if (! $store) {
            return StoreProfileConstant::STORE_NOT_FOUND;
        }

        $subscriptionCurrent = $this->subscriptionManager->getSubscriptionCurrentWithRelation($store->getStoreOwnerId());

        if (! $subscriptionCurrent) {
            return SubscriptionConstant::YOU_DO_NOT_HAVE_SUBSCRIBED;
        }

        $request->setPackage($subscriptionCurrent['packageId']);

        $request->setStoreOwner($store->getStoreOwnerId());

        return $this->createSubscription($request);
    }

    public function deleteStoreSubscriptionBySubscriptionId(int $subscriptionId): ?SubscriptionEntity
    {
        return $this->subscriptionManager->deleteStoreSubscriptionBySubscriptionId($subscriptionId);
    }

    // This function only checks remaining cars without any updating operations
//    public function checkRemainingCarsOnlyByOrderId(int $orderId): string|int
//    {
//        $subscription = $this->subscriptionManager->getSubscriptionCurrentByOrderId($orderId);
//
//        if($subscription) {
//            return $subscription['remainingCars'];
//        }
//
//        return SubscriptionConstant::YOU_DO_NOT_HAVE_SUBSCRIBED;
//    }

    public function checkRemainingCarsAndInformStore(int $currentRemainingCars, int $newRemainingCars, $subscription): void
    {
        $subscriptionEntity = $this->getSubscriptionEntityById($subscription['id']);

        if ($subscriptionEntity) {
            // Now check if we have to inform the store there is new available car/s or not
            $this->subscriptionNotificationService->checkRemainingCarsAndInformStore($currentRemainingCars, $newRemainingCars,
                $subscriptionEntity->getStoreOwner()->getStoreOwnerId());
        }
    }

    /**
     * Get the sum of the unpaid cash orders to store
     */
    public function getUnPaidStoreOwnerDuesFromCashOrderSumByStoreSubscriptionId(int $subscriptionId): float
    {
        return $this->storeOwnerDueFromCashOrderGetService->getUnPaidStoreOwnerDuesFromCashOrderSumByStoreSubscriptionId($subscriptionId);
    }

    // Send firebase notification to each admin about the action that being made on subscription by a store
    public function sendFirebaseNotificationToAdmin(string $notificationDescription, string $storeName = null, int $storeOwnerUserId = null)
    {
        if ((! $storeName) && ($storeOwnerUserId)) {
            // Get store owner name before sending the notification
            $storeName = $this->getStoreNameByStoreOwnerUserId($storeOwnerUserId);
        }

        $this->subscriptionFirebaseNotificationService->sendFirebaseNotificationToAdmin($notificationDescription, $storeName);
    }

    public function getStoreOwnerProfileByStoreOwnerUserId(int $storeOwnerUserId): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileService->getStoreByUserId($storeOwnerUserId);
    }

    public function getStoreNameByStoreOwnerUserId(int $storeOwnerUserId): ?string
    {
        $storeOwnerEntity = $this->getStoreOwnerProfileByStoreOwnerUserId($storeOwnerUserId);

        if ($storeOwnerEntity) {
            return $storeOwnerEntity->getStoreOwnerName();
        }

        return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
    }

    // Check if remaining orders of a store subscription has negative value, and send firebase notification to admin if it is
    public function checkRemainingOrdersOfStoreSubscriptionAndInformAdmin(int $remainingOrders, int $storeOwnerUserId)
    {
        if ($remainingOrders < 0) {
            // Notify admin by firebase notification
            $this->sendFirebaseNotificationToAdmin(SubscriptionFirebaseNotificationConstant::STORE_SUBSCRIPTION_REMAINING_ORDER_NEGATIVE_VALUE_CONST,
                null, $storeOwnerUserId);
        }
    }

    // Check if remaining orders of a store subscription has negative value, and send firebase notification to admin if it is
    public function checkRemainingCarsOfStoreSubscriptionAndInformAdmin(int $remainingCars, string $storeOwnerName)
    {
        if ($remainingCars < 0) {
            // Notify admin by firebase notification
            $this->sendFirebaseNotificationToAdmin(SubscriptionFirebaseNotificationConstant::STORE_SUBSCRIPTION_REMAINING_CARS_NEGATIVE_VALUE_CONST,
                $storeOwnerName, null);
        }
    }

    public function getSubscriptionDetailsByStoreOwnerProfileId(int $storeOwnerProfileId): ?SubscriptionDetailsEntity
    {
        return $this->subscriptionDetailsService->getSubscriptionDetailsByStoreOwnerProfileId($storeOwnerProfileId);
    }

    private function updateRemainingOrdersOfStoreSubscriptionBySubscriptionDetailsId(int $subscriptionDetailsId, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        $subscriptionDetailsResult = $this->subscriptionDetailsService->updateRemainingOrdersOfStoreSubscriptionBySubscriptionDetailsId($subscriptionDetailsId,
            $operationType, $factor);

        if ($subscriptionDetailsResult === SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        return $subscriptionDetailsResult;
    }

    public function handleUpdatingRemainingOrdersOfStoreSubscription(int $storeOwnerProfileId, DateTimeInterface $orderCreationDate, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        // In order to update the store subscription, firstly, we have to check if order belong to the subscription being updated
        // Get current subscription
        $currentSubscriptionDetails = $this->getSubscriptionDetailsByStoreOwnerProfileId($storeOwnerProfileId);

        if (! $currentSubscriptionDetails) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        // Check if order belong to the current subscription
        if (! $this->storeSubscriptionCheckService->checkIfOrderBelongToStoreSubscriptionByOrderCreationDateAndSubscriptionValidationDate($orderCreationDate,
            $currentSubscriptionDetails->getLastSubscription()->getStartDate(), $currentSubscriptionDetails->getLastSubscription()->getEndDate())) {
            return OrderResultConstant::ORDER_DOES_NOT_BELONG_TO_SUBSCRIPTION;
        }

        // Check if we can update the remaining orders of the current subscription
        $updateOrderResult = $this->storeSubscriptionCheckService->checkIfUpdateRemainingOrdersAllowed($operationType,
            $currentSubscriptionDetails->getRemainingOrders(), $factor,
            $currentSubscriptionDetails->getLastSubscription()->getPackage()->getOrderCount());

        if ((! $updateOrderResult) || ($updateOrderResult === SubscriptionConstant::WRONG_SUBSCRIPTION_UPDATE_OPERATION_CONST)) {
            ////TODO Also, we can send firebase notification to admin in order to inform about reaching negative value
            return SubscriptionDetailsConstant::REMAINING_ORDERS_CAN_NOT_BE_UPDATED;
        }

        // Now we can update the remaining orders
        $result = $this->updateRemainingOrdersOfStoreSubscriptionBySubscriptionDetailsId($currentSubscriptionDetails->getId(),
            $operationType, $factor);

        if ($result === SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        // After applying the updating process, check the subscription status (ex: if remaining cars are finished)
        //$this->checkSubscriptionValidation();
        return $result;
    }

    public function updateRemainingCarsOfStoreSubscriptionBySubscriptionDetailsId(int $subscriptionDetailsId, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        return $this->subscriptionDetailsService->updateRemainingCarsOfStoreSubscriptionBySubscriptionDetailsId($subscriptionDetailsId,
            $operationType, $factor);
    }

    // Responsible for handling the updating remaining cars field of a specific store subscription
    // The handling includes check if we can update the field and calling the related updating function, if it is allowed
    // Note: factor is the parameter that we want to subtract/add from/to remaining cars field
    public function handleUpdatingRemainingCarsOfStoreSubscriptionViaStoreOwnerProfileIdAndOrderCreationDate(int $storeOwnerProfileId, DateTimeInterface $orderCreationDate, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        // In order to update the store subscription, firstly, we have to check if order belong to the subscription being updated
        // Get current subscription
        $currentSubscriptionDetails = $this->getSubscriptionDetailsByStoreOwnerProfileId($storeOwnerProfileId);

        if (! $currentSubscriptionDetails) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        // Check if order belong to the current subscription
        if (! $this->storeSubscriptionCheckService->checkIfOrderBelongToStoreSubscriptionByOrderCreationDateAndSubscriptionValidationDate($orderCreationDate,
            $currentSubscriptionDetails->getLastSubscription()->getStartDate(), $currentSubscriptionDetails->getLastSubscription()->getEndDate())) {
            return OrderResultConstant::ORDER_DOES_NOT_BELONG_TO_SUBSCRIPTION;
        }

        // Check if we can update the remaining cars of the current subscription
        $updateCarResult = $this->storeSubscriptionCheckService->checkIfUpdateRemainingCarsAllowed($operationType,
            $currentSubscriptionDetails->getRemainingCars(), $factor,
            $currentSubscriptionDetails->getLastSubscription()->getPackage()->getCarCount());

        if ((! $updateCarResult) || ($updateCarResult === SubscriptionConstant::WRONG_SUBSCRIPTION_UPDATE_OPERATION_CONST)) {
            return SubscriptionDetailsConstant::REMAINING_CARS_CAN_NOT_BE_UPDATED;
        }

        // Now we can update the remaining cars
        $result = $this->updateRemainingCarsOfStoreSubscriptionBySubscriptionDetailsId($currentSubscriptionDetails->getId(),
            $operationType, $factor);

        if ($result === SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        // After applying the updating process, check the subscription status (ex: if remaining cars are finished)
        //$this->checkSubscriptionValidation();
        return $result;
    }

    public function getPackageEntityById(int $id): ?PackageEntity
    {
        return $this->subscriptionManager->getPackageEntityById($id);
    }

    public function createSubscriptionWithFreePackage(int $storeOwnerUserId): string|int|SubscriptionEntity|SubscriptionResponse
    {
        $freePackage = $this->getPackageEntityById(18);

        if (! $freePackage) {
            return PackageConstant::PACKAGE_NOT_EXIST;
        }

        $createRequest = new SubscriptionCreateRequest();

        $createRequest->setPackage($freePackage);

        $activateExistingSubscription = $this->checkSubscription($storeOwnerUserId);

        $isFuture = $this->getIsFutureState($storeOwnerUserId);

        $createRequest->setIsFuture($isFuture);
        $createRequest->setHasExtra(SubscriptionConstant::IS_HAS_EXTRA_FALSE);
        $createRequest->setType(SubscriptionConstant::POSSIBLE_TO_EXTRA_FALSE);
        $createRequest->setStoreOwner($storeOwnerUserId);

        $subscription = $this->subscriptionManager->createSubscriptionWithFreePackage($createRequest);

        //--check and update completeAccountStatus for the store owner profile
        if ($subscription) {
            $this->updateCompleteAccountStatusOfStoreOwnerProfileAfterSubscriptionWithFreePackage($subscription->getStoreOwner());

            if ($activateExistingSubscription === SubscriptionConstant::NEW_SUBSCRIPTION_ACTIVATED) {
                $this->checkWhetherThereIsActiveCaptainsOfferAndUpdateSubscription($createRequest->getStoreOwner()->getId());

                return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $subscription);
            }

            $this->checkWhetherThereIsActiveCaptainsOfferAndUpdateSubscription($subscription->getStoreOwner()->getId());

            // Send firebase notification to admin
            $this->sendFirebaseNotificationToAdmin(SubscriptionFirebaseNotificationConstant::STORE_CREATE_NEW_SUBSCRIPTION_CONST,
                $subscription->getStoreOwner()->getStoreOwnerName(), $storeOwnerUserId);

            //return $this->autoMapping->map(SubscriptionEntity::class, SubscriptionResponse::class, $subscription);
            return $subscription;
        }

        return SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST;
    }

    /**
     * This function checks completeAccountStatus of the store owner profile and updates it when necessary
     */
    public function updateCompleteAccountStatusOfStoreOwnerProfileAfterSubscriptionWithFreePackage(StoreOwnerProfileEntity $storeOwner)
    {
        // First, check if there is a subscription
        $subscriptionHistory = $this->subscriptionManager->getSubscriptionHistoryByStoreOwner($storeOwner);

        if ($subscriptionHistory != null) {
            // subscription is exist, then check completeAccountStatus field.
            $storeOwnerProfileResult = $this->subscriptionManager->getStoreOwnerProfileByStoreOwnerId($storeOwner->getStoreOwnerId());

            if ($storeOwnerProfileResult) {
                if ($storeOwnerProfileResult->getCompleteAccountStatus() === StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_BRANCH_CREATED
                    || ($storeOwnerProfileResult->getCompleteAccountStatus() === StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_BEFORE_FREE_SUBSCRIPTION_CONST)) {
                    // then we can update completeAccountStatus to subscriptionCreated

                    $completeAccountStatusUpdateRequest = new CompleteAccountStatusUpdateRequest();

                    $completeAccountStatusUpdateRequest->setUserId($storeOwner->getStoreOwnerId());
                    $completeAccountStatusUpdateRequest->setCompleteAccountStatus(StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_FREE_SUBSCRIPTION_CREATED);

                    $this->subscriptionManager->storeOwnerProfileCompleteAccountStatusUpdate($completeAccountStatusUpdateRequest);
                }
            }
        }
    }

    public function checkDeliveredOrdersCostTillNow(int $storeOwnerUserId, int $subscriptionId): float
    {
        $ordersCostSum = $this->subscriptionManager->checkDeliveredOrdersCostTillNow($storeOwnerUserId, $subscriptionId);

        if (count($ordersCostSum) === 0) {
            return 0.0;
        }

        return $ordersCostSum[0];
    }

    public function getSubscriptionDetailsEntityByStoreOwnerUserId(int $storeOwnerId): ?SubscriptionDetailsEntity
    {
        return $this->subscriptionManager->getSubscriptionCurrent($storeOwnerId);
    }

    private function deActivateCurrentSubscriptionByStoreOwnerUserId(int $storeOwnerId): SubscriptionDetailsEntity|string
    {
        $subscriptionDetailsEntity = $this->getSubscriptionDetailsEntityByStoreOwnerUserId($storeOwnerId);

        if ($subscriptionDetailsEntity) {
            return $this->subscriptionManager->updateSubscriptionStatusToDateFinishedBySubscriptionDetailsEntity($subscriptionDetailsEntity);
        }

        return SubscriptionConstant::SUBSCRIPTION_NOT_FOUND;
    }

    public function updateCurrentSubscriptionPaidFlagByStoreOwnerUserId(int $storeOwnerUserId, int $paidFlag): SubscriptionEntity|string
    {
        $subscriptionDetailsEntity = $this->getSubscriptionDetailsEntityByStoreOwnerUserId($storeOwnerUserId);

        if (! $subscriptionDetailsEntity) {
            return SubscriptionConstant::SUBSCRIPTION_NOT_FOUND;
        }

        return $this->subscriptionManager->updateSubscriptionPaidFlagBySubscriptionEntity($subscriptionDetailsEntity->getLastSubscription(),
            $paidFlag);
    }

    public function getDeliveredOrdersDeliveryCostFromSubscriptionStartDateTillNow(int $storeOwnerUserId, int $subscriptionId): array
    {
        return $this->subscriptionManager->getDeliveredOrdersDeliveryCostFromSubscriptionStartDateTillNow($storeOwnerUserId,
            $subscriptionId);
    }

    public function getCurrentSubscriptionBalanceByStoreOwner(int $storeOwnerUserId): string|CurrentStoreSubscriptionBalanceGetResponse
    {
        $response = [];
        $response['deliveredOrdersCount'] = 0;
        $response['deliveredOrdersCostsSum'] = 0.0;
        $response['hasToPay'] = false;
        $response['subscriptionCostLimit'] = 100;
        $response['openingOrderCost'] = 0;
        $response['oneKilometerCost'] = 0;

        $subscriptionDetailsEntity = $this->getSubscriptionDetailsEntityByStoreOwnerUserId($storeOwnerUserId);

        if (! $subscriptionDetailsEntity) {
            return SubscriptionConstant::SUBSCRIPTION_NOT_FOUND;
        }

        $subscription = $subscriptionDetailsEntity->getLastSubscription();

        if ($subscription) {
            $response['openingOrderCost'] = $subscription->getPackage()->getOpeningOrderCost();
            $response['oneKilometerCost'] = $subscription->getPackage()->getOneKilometerCost();
        }

        $response['subscriptionStatus'] = $subscription->getStatus();
        $response['subscriptionStartDate'] = $subscription->getStartDate();

        $storePreferences = $subscription->getStoreOwner()->getStoreOwnerPreferenceEntity();

        if ($storePreferences) {
            $response['subscriptionCostLimit'] = $storePreferences->getSubscriptionCostLimit();
        }

        $orders = $this->getDeliveredOrdersDeliveryCostFromSubscriptionStartDateTillNow($storeOwnerUserId,
            $subscription->getId());

        $ordersCount = count($orders);

        if ($ordersCount > 0) {
            $response['deliveredOrdersCount'] = $ordersCount;

            foreach ($orders as $order) {
                $response['deliveredOrdersCostsSum'] += $order['deliveryCost'];
            }

            if ($response['deliveredOrdersCostsSum'] >= $response['subscriptionCostLimit']) {
                $response['hasToPay'] = true;
            }
        }

        return $this->autoMapping->map('array', CurrentStoreSubscriptionBalanceGetResponse::class, $response);
    }

    public function getStoreOwnerPreferenceSubscriptionCostLimitByStoreOwnerUserId(int $storeOwnerUserId): float|int|string|null
    {
        $storeOwnerProfile = $this->getStoreOwnerProfileByStoreOwnerUserId($storeOwnerUserId);

        if (! $storeOwnerProfile) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        $storePreference = $storeOwnerProfile->getStoreOwnerPreferenceEntity();

        if (! $storePreference) {
            return StoreOwnerPreferenceConstant::STORE_OWNER_PREFERENCE_NOT_EXIST_CONST;
        }

        return $storePreference->getSubscriptionCostLimit();
    }
}
 
