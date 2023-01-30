<?php

namespace App\Service\Admin\StoreOwnerSubscription;

use App\AutoMapping;
use App\Constant\Admin\Subscription\AdminStoreSubscriptionConstant;
use App\Constant\Order\OrderResultConstant;
use App\Constant\Subscription\SubscriptionDetailsConstant;
use App\Entity\SubscriptionDetailsEntity;
use App\Entity\SubscriptionEntity;
use App\Manager\Admin\StoreOwnerSubscription\AdminStoreSubscriptionManager;
use App\Request\Admin\Subscription\CreateNewStoreSubscriptionWithSamePackageByAdminRequest;
use App\Request\Admin\Subscription\StoreSubscription\StoreSubscriptionRemainingCarsUpdateByAdminRequest;
use App\Request\Subscription\SubscriptionStatusUpdateByAdminRequest;
use App\Response\Admin\StoreOwnerSubscription\AdminStoreSubscriptionResponse;
use App\Response\Admin\StoreOwnerSubscription\StoreFutureSubscriptionGetForAdminResponse;
use App\Response\Admin\StoreOwnerSubscription\SubscriptionRemainingCarsUpdateByAdminResponse;
use App\Response\Subscription\RemainingOrdersResponse;
use App\Service\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentService;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Service\Eraser\Subscription\StoreSubscriptionEraserService;
use App\Service\Subscription\StoreSubscriptionCheckService;
use App\Service\Subscription\StoreSubscriptionHandleService;
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
use App\Response\Admin\StoreOwnerSubscription\AdminDeleteSubscriptionResponse;
use App\Request\Admin\Subscription\AdminCalculateCostDeliveryOrderRequest;
use App\Response\Subscription\CalculateCostDeliveryOrderResponse;
use App\Constant\Package\PackageConstant;
use DateTimeInterface;

class AdminStoreSubscriptionService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminStoreSubscriptionManager $adminStoreSubscriptionManager,
        private AdminStoreOwnerPaymentService $adminStoreOwnerPaymentService,
        private SubscriptionService $subscriptionService,
        private StoreSubscriptionEraserService $storeSubscriptionEraserService,
        private AdminStoreSubscriptionDetailsService $adminStoreSubscriptionDetailsService,
        private StoreSubscriptionCheckService $storeSubscriptionCheckService,
        private StoreSubscriptionHandleService $storeSubscriptionHandleService
    )
    {
    }

    public function getSubscriptionsWithPaymentsSpecificStore(int $storeId): array
    {
       $response = [];
       //check Subscription
       $this->subscriptionService->packageBalanceForAdminByStoreOwnerProfileId($storeId);
       
       $subscriptions = $this->adminStoreSubscriptionManager->getSubscriptionsSpecificStoreForAdmin($storeId);

       foreach ($subscriptions as $subscription) {

            if( ! $subscription['remainingCars'] ) {
                $subscription['remainingCars'] = 0;
            }
            if( ! $subscription['remainingOrders'] ) {
                $subscription['remainingOrders'] = 0;
            }

            $subscription['isCurrent'] = SubscriptionConstant::SUBSCRIBE_NOT_CURRENT_BOOLEAN;
            
            if($subscription['subscriptionDetailsId']) {
                
                $subscription['isCurrent'] = SubscriptionConstant::SUBSCRIBE_CURRENT_BOOLEAN;
                $subscription['subscriptionRemainingCars'] = $subscription['remainingCars'];
                $subscription['subscriptionRemainingOrders'] = $subscription['remainingOrders'];
            }

            $subscription['paymentsFromStore'] = $this->adminStoreOwnerPaymentService->getStorePaymentsBySubscriptionId($subscription['id']);
          
            $subscription['captainOffers'] = $this->adminStoreSubscriptionManager->getCaptainOffersBySubscriptionIdForAdmin($subscription['id']);
            
            $subscription['ordersExceedGeographicalRange'] = $this->subscriptionService->getOrdersExceedGeographicalRangeBySubscriptionIdAndGeographicalRange($subscription['id'], (float)$subscription['packageGeographicalRange']);
          
            $totalExtraDistance = $this->subscriptionService->getTotalExtraDistance($subscription['ordersExceedGeographicalRange'], (float)$subscription['packageGeographicalRange']);
            //if package is on order
            if ($subscription['packageType'] === PackageConstant::PACKAGE_TYPE_ON_ORDER) {
                $subscription['total'] = $this->subscriptionService->getTotalWithPackageOnOrder($subscription['paymentsFromStore'], $subscription['packageCost'], $subscription['captainOffers'], (float)$subscription['packageExtraCost'], $totalExtraDistance, $subscription['id']);
            }
            else {
                $subscription['total'] = $this->getTotal($subscription['paymentsFromStore'], $subscription['packageCost'], $subscription['captainOffers'],(float)$subscription['packageExtraCost'], $totalExtraDistance);
            }

            if (($subscription['isCurrent'] === 0) && ($subscription['isFuture'] === false) && (! $subscription['subscriptionDetailsId'])) {
                $response['oldSubscriptions'][] = $this->autoMapping->map("array", AdminStoreSubscriptionResponse::class, $subscription);

            } else {
                $response['currentAndFutureSubscriptions'][] = $this->autoMapping->map("array", AdminStoreSubscriptionResponse::class, $subscription);
            }
        }

        return $response;
    }

    //Get the cost of regular subscriptions
    public function getTotal(array $payments, float $packageCost, array $captainOffers, float $packageExtraCost, int $totalDistanceExtra): array
    {
        $item['totalDistanceExtra'] = $totalDistanceExtra;

        $item['sumPayments'] = array_sum(array_map(fn ($payment) => $payment->amount, $payments));
      
        $sumCaptainOfferPrices = 0;
       
        foreach($captainOffers as $captainOffer) {
            if($captainOffer['captainOfferFirstTime'] === true) {
                $sumCaptainOfferPrices += $captainOffer['price'];
            }
        }
      
        $item['extraCost'] = $packageExtraCost * $item['totalDistanceExtra'];

        $item['packageCost'] = $packageCost;

        $item['captainOfferPrice'] = $sumCaptainOfferPrices;
           
        $item['requiredToPay'] = $packageCost + $sumCaptainOfferPrices + $item['extraCost'];
        
        $total =  $item['requiredToPay'] - $item['sumPayments'];
       
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
    
    public function deleteSubscriptionByAdmin(AdminDeleteSubscriptionRequest $request): AdminDeleteSubscriptionResponse |null|int
    {
        //delete subscription with payments
        if ($request->getDeletePayment() === PaymentConstant::DELETE_SUBSCRIPTION_WITH_PAYMENT) {
           
            $payments = $this->adminStoreOwnerPaymentService->getStorePaymentsBySubscriptionId($request->getId());

            if (count($payments) > 0) {
                foreach ($payments as $payment) {
                    $this->adminStoreOwnerPaymentService->deleteStoreOwnerPayment($payment->id);
                }
            }

            $subscription = $this->adminStoreSubscriptionManager->getSubscriptionEntityByIdForAdmin($request->getId());

            if ($subscription) {
                $subscriptionDeleteResult = $this->storeSubscriptionEraserService->deleteCurrentStoreOwnerSubscriptionBySubscriptionId($subscription->getId());

                if ($subscriptionDeleteResult === AdminStoreSubscriptionConstant::STORE_SUBSCRIPTIONS_DELETED_SUCCESSFULLY) {
                    return $this->autoMapping->map(SubscriptionEntity::class, AdminDeleteSubscriptionResponse::class, $subscription);
                }
            }
        }

        // get payments with subscription id
        $payments = $this->adminStoreOwnerPaymentService->getStorePaymentsBySubscriptionId($request->getId());

        //if not found payments , delete subscription
        if(count($payments) === 0) {
            $subscription = $this->adminStoreSubscriptionManager->getSubscriptionEntityByIdForAdmin($request->getId());

            if ($subscription) {
                $subscriptionDeleteResult = $this->storeSubscriptionEraserService->deleteCurrentStoreOwnerSubscriptionBySubscriptionId($subscription->getId());

                if ($subscriptionDeleteResult === AdminStoreSubscriptionConstant::STORE_SUBSCRIPTIONS_DELETED_SUCCESSFULLY) {
                    return $this->autoMapping->map(SubscriptionEntity::class, AdminDeleteSubscriptionResponse::class, $subscription);
                }
            }
        }

        return PaymentConstant::THERE_ARE_PAYMENT_RELATED_WITH_SUBSCRIPTION;
    }

    public function calculateCostDeliveryOrderForAdmin(AdminCalculateCostDeliveryOrderRequest $request): CalculateCostDeliveryOrderResponse
    {
        return $this->subscriptionService->calculateCostDeliveryOrderForAdmin($request);
    }

    public function packageBalanceForAdminByStoreOwnerId(int $storeOwnerId): RemainingOrdersResponse|string
    {
        return $this->subscriptionService->packageBalance($storeOwnerId);
    }

    public function createNewSubscriptionForSamePackageByAdmin(CreateNewStoreSubscriptionWithSamePackageByAdminRequest $requestByAdmin): SubscriptionResponse|SubscriptionErrorResponse|string|int
    {
        $request = new SubscriptionCreateRequest();

        $request->setNote($requestByAdmin->getNote());

        return $this->subscriptionService->createNewSubscriptionForSamePackageByAdmin($request, $requestByAdmin->getStoreProfileId());
    }

    public function getSubscriptionDetailsByStoreOwnerProfileIdForAdmin(int $storeOwnerProfileId): ?SubscriptionDetailsEntity
    {
        return $this->adminStoreSubscriptionDetailsService->getSubscriptionDetailsByStoreOwnerProfileIdForAdmin($storeOwnerProfileId);
    }

    public function handleUpdatingRemainingOrdersOfStoreSubscriptionByAdmin(int $storeOwnerProfileId, DateTimeInterface $orderCreationDate, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        // In order to update the store subscription, firstly, we have to check if order belong to the subscription being updated
        // Get current subscription
        $currentSubscriptionDetails = $this->getSubscriptionDetailsByStoreOwnerProfileIdForAdmin($storeOwnerProfileId);

        if (! $currentSubscriptionDetails) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        // Check if order belong to the current subscription
        if (! $this->storeSubscriptionCheckService->checkIfOrderBelongToStoreSubscriptionByOrderCreationDateAndSubscriptionValidationDate($orderCreationDate,
            $currentSubscriptionDetails->getLastSubscription()->getStartDate(), $currentSubscriptionDetails->getLastSubscription()->getEndDate())) {
            return OrderResultConstant::ORDER_DOES_NOT_BELONG_TO_SUBSCRIPTION;
        }

        // Check if we can update the remaining orders of the current subscription
        $updateOrderResult = $this->storeSubscriptionCheckService->checkIfUpdateRemainingOrdersAllowed(
            $operationType,
            $currentSubscriptionDetails->getRemainingOrders(),
            $factor,
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

    // Responsible for handling the updating remaining cars field of a specific store subscription
    // The handling includes check if we can update the field and calling the related updating function, if it is allowed
    // Note: factor is the parameter that we want to subtract/add from/to remaining cars field
    public function handleUpdatingRemainingCarsOfStoreSubscriptionViaStoreOwnerProfileIdAndOrderCreationDateByAdmin(int $storeOwnerProfileId, DateTimeInterface $orderCreationDate, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        // In order to update the store subscription, firstly, we have to check if order belong to the subscription being updated
        // Get current subscription
        $currentSubscriptionDetails = $this->getSubscriptionDetailsByStoreOwnerProfileIdForAdmin($storeOwnerProfileId);

        if (! $currentSubscriptionDetails) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        // Check if order belong to the current subscription
        if (! $this->storeSubscriptionCheckService->checkIfOrderBelongToStoreSubscriptionByOrderCreationDateAndSubscriptionValidationDate($orderCreationDate,
            $currentSubscriptionDetails->getLastSubscription()->getStartDate(), $currentSubscriptionDetails->getLastSubscription()->getEndDate())) {
            return OrderResultConstant::ORDER_DOES_NOT_BELONG_TO_SUBSCRIPTION;
        }

        // Check if we can update the remaining cars of the current subscription
        $updateCarResult = $this->storeSubscriptionCheckService->checkIfUpdateRemainingCarsAllowed(
            $operationType,
            $currentSubscriptionDetails->getRemainingCars(),
            $factor,
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

    private function updateRemainingOrdersOfStoreSubscriptionBySubscriptionDetailsId(int $subscriptionDetailsId, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        $subscriptionDetailsResult = $this->adminStoreSubscriptionDetailsService->updateRemainingOrdersOfStoreSubscriptionBySubscriptionDetailsId($subscriptionDetailsId,
            $operationType, $factor);

        if ($subscriptionDetailsResult === SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        return $subscriptionDetailsResult;
    }

    public function updateRemainingCarsOfStoreSubscriptionBySubscriptionDetailsId(int $subscriptionDetailsId, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        return $this->adminStoreSubscriptionDetailsService->updateRemainingCarsOfStoreSubscriptionBySubscriptionDetailsId($subscriptionDetailsId,
            $operationType, $factor);
    }

    /**
     * ////TODO to be continued
     * This suppose to check the subscription remaining cars, remaining orders, date, and do the necessary update/s
     */
    public function checkSubscriptionValidation(int $storeOwnerUserId): string
    {
        ///TODO temporary depending on following function, but later will depend on StoreSubscriptionHandleService service
        return $this->subscriptionService->checkSubscription($storeOwnerUserId);

        ///TODO Following function will be use when StoreSubscriptionHandleService is ready
        //$checkSubscriptionResult = $this->storeSubscriptionHandleService->checkCurrentSubscriptionSituationAndUpdateIt($subscriptionDetailsEntity);
    }

    public function updateCurrentSubscriptionStatus(SubscriptionStatusUpdateByAdminRequest $request): SubscriptionEntity|int
    {
        return $this->adminStoreSubscriptionManager->updateCurrentSubscriptionStatus($request);
    }

    public function updateCurrentSubscriptionDetailsStatus(SubscriptionStatusUpdateByAdminRequest $request): SubscriptionDetailsEntity|int
    {
        return $this->adminStoreSubscriptionDetailsService->updateCurrentSubscriptionDetailsStatus($request);
    }

    public function initializeAndGetSubscriptionStatusUpdateByAdminRequest(): SubscriptionStatusUpdateByAdminRequest
    {
        $subscriptionStatusUpdateRequest = new SubscriptionStatusUpdateByAdminRequest();

        $subscriptionStatusUpdateRequest->setId(0);
        $subscriptionStatusUpdateRequest->setStatus(SubscriptionConstant::SUBSCRIBE_ACTIVE);

        return $subscriptionStatusUpdateRequest;
    }

    public function getCurrentSubscriptionIdBySubscriptionDetailsId(int $subscriptionDetailsId): ?int
    {
        return $this->adminStoreSubscriptionDetailsService->getCurrentSubscriptionIdBySubscriptionDetailsId($subscriptionDetailsId);
    }

    public function updateCurrentSubscriptionAndSubscriptionDetailsStatusBySubscriptionDetailsId(int $subscriptionDetailsId, string $status): SubscriptionDetailsEntity|int
    {
        // Get current subscription id
        $currentSubscriptionId = $this->getCurrentSubscriptionIdBySubscriptionDetailsId($subscriptionDetailsId);

        if ($currentSubscriptionId === SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST) {
            return SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST;
        }

        // create required request
        $subscriptionStatusUpdateRequest = $this->initializeAndGetSubscriptionStatusUpdateByAdminRequest();

        // update the status of the current subscription
        $subscriptionStatusUpdateRequest->setId($currentSubscriptionId);
        $subscriptionStatusUpdateRequest->setStatus($status);

        $updateCurrentSubscriptionStatusResult = $this->updateCurrentSubscriptionStatus($subscriptionStatusUpdateRequest);

        if ($updateCurrentSubscriptionStatusResult === SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST) {
            return SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST;
        }

        // update the status of the current subscription details
        $subscriptionStatusUpdateRequest->setId($subscriptionDetailsId);
        $subscriptionStatusUpdateRequest->setStatus($status);

        $updateCurrentSubscriptionStatusResult = $this->updateCurrentSubscriptionDetailsStatus($subscriptionStatusUpdateRequest);

        if ($updateCurrentSubscriptionStatusResult === SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST) {
            return SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST;
        }

        return $updateCurrentSubscriptionStatusResult;
    }

    public function checkCurrentSubscriptionDateAndRemainingOrdersBySubscription(
         DateTimeInterface $subscriptionStartDate,
         DateTimeInterface $subscriptionEndDate,
         bool $hasExtra,
         int $subscriptionRemainingOrders,
         int $packageOrdersCount): int
    {
        return $this->storeSubscriptionHandleService->checkCurrentSubscriptionDateAndRemainingOrders($subscriptionStartDate,
            $subscriptionEndDate, $hasExtra, $subscriptionRemainingOrders, $packageOrdersCount);
    }

    private function getSubscriptionDetailsBySubscriptionIdAndSpecificGroupOfStatus(int $subscriptionId, array $statusArray): ?SubscriptionDetailsEntity
    {
        return $this->adminStoreSubscriptionDetailsService->getSubscriptionDetailsBySubscriptionIdAndSpecificGroupOfStatusForAdmin($subscriptionId,
        $statusArray);
    }

    // Check if we can update remaining cars and if the required update is allowed
    // Note: factor is the parameter that we want to subtract/add from/to remaining cars field
    public function checkIfUpdatingRemainingCarsOfStoreSubscriptionViaSubscriptionIdByAdminAreAllowed(int $subscriptionId, string $operationType, int $factor)
    {
        // 1. Check and get current subscription details (if exists)
        // Get current subscription (but only if it is active, or cars finished)
        $currentSubscriptionDetails = $this->getSubscriptionDetailsBySubscriptionIdAndSpecificGroupOfStatus($subscriptionId,
            [SubscriptionConstant::CARS_FINISHED, SubscriptionConstant::SUBSCRIBE_ACTIVE]);

        if (! $currentSubscriptionDetails) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        // 2. Check if subscription is a valid one
        // Check subscription date and remaining orders
        $checkDateAndRemainingOrdersResult = $this->checkCurrentSubscriptionDateAndRemainingOrdersBySubscription($currentSubscriptionDetails->getLastSubscription()->getStartDate(),
            $currentSubscriptionDetails->getLastSubscription()->getEndDate(), $currentSubscriptionDetails->getHasExtra(),
            $currentSubscriptionDetails->getRemainingOrders(), $currentSubscriptionDetails->getLastSubscription()->getPackage()->getOrderCount());

        if (($checkDateAndRemainingOrdersResult === SubscriptionConstant::SUBSCRIPTION_DATE_IS_FINISHED_CONST)) {
            return SubscriptionConstant::SUBSCRIPTION_DATE_IS_FINISHED_CONST;

        } elseif (($checkDateAndRemainingOrdersResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_FINISHED)
            || ($checkDateAndRemainingOrdersResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_BIGGER_THAN_PACKAGE_ORDERS_CONST)
            || ($checkDateAndRemainingOrdersResult === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_LESS_THAN_ZERO_CONST)) {
            return $checkDateAndRemainingOrdersResult;
        }

        // 3. Check if we can perform the required operation
        // Check if we can update the remaining cars of the current subscription
        $updateCarResult = $this->storeSubscriptionCheckService->checkIfUpdateRemainingCarsAllowed(
            $operationType,
            $currentSubscriptionDetails->getRemainingCars(),
            $factor,
            $currentSubscriptionDetails->getLastSubscription()->getPackage()->getCarCount());

        if ((! $updateCarResult)
            || ($updateCarResult === SubscriptionConstant::WRONG_SUBSCRIPTION_UPDATE_OPERATION_CONST)) {
            return SubscriptionDetailsConstant::REMAINING_CARS_CAN_NOT_BE_UPDATED;
        }

        return $currentSubscriptionDetails;
    }

    public function updateStoreSubscriptionRemainingCarsByAdmin(StoreSubscriptionRemainingCarsUpdateByAdminRequest $request): SubscriptionRemainingCarsUpdateByAdminResponse|int
    {
        // 1. Check and get current subscription details (if exists)
        $currentSubscriptionDetails = $this->checkIfUpdatingRemainingCarsOfStoreSubscriptionViaSubscriptionIdByAdminAreAllowed($request->getId(),
            $request->getOperationType(), $request->getFactor());

        if ($currentSubscriptionDetails === SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;

        } elseif ($currentSubscriptionDetails === SubscriptionConstant::SUBSCRIPTION_DATE_IS_FINISHED_CONST) {
            return SubscriptionConstant::SUBSCRIPTION_DATE_IS_FINISHED_CONST;

        } elseif ($currentSubscriptionDetails === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_FINISHED) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_FINISHED;

        } elseif (($currentSubscriptionDetails === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_BIGGER_THAN_PACKAGE_ORDERS_CONST)
            || ($currentSubscriptionDetails === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_LESS_THAN_ZERO_CONST)) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_OUT_OF_LIMITS_CONST;

        } elseif ($currentSubscriptionDetails === SubscriptionDetailsConstant::REMAINING_CARS_CAN_NOT_BE_UPDATED) {
            return SubscriptionDetailsConstant::REMAINING_CARS_CAN_NOT_BE_UPDATED;
        }

        // 2. Do the required update
        // Now we can update the remaining cars
        $subscriptionDetailsResult = $this->updateRemainingCarsOfStoreSubscriptionBySubscriptionDetailsId($currentSubscriptionDetails->getId(),
            $request->getOperationType(), $request->getFactor());

        if ($subscriptionDetailsResult === SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        // 3. As long as subscription date is valid, and remaining orders is valid, and the updated remaining cars is allowed
        // and it had been made, then we just need to make sure that the subscription status is active (by updating it)
//        $updateSubscriptionStatusResult = $this->updateCurrentSubscriptionAndSubscriptionDetailsStatusBySubscriptionDetailsId($subscriptionDetailsResult->getId(),
//            SubscriptionConstant::SUBSCRIBE_ACTIVE);

        $updateSubscriptionStatusResult = $this->checkSubscriptionValidation($subscriptionDetailsResult->getStoreOwner()->getStoreOwnerId());

        //if ($updateSubscriptionStatusResult === SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST) {
          //  return SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST;
        //}

        return $this->autoMapping->map(SubscriptionDetailsEntity::class, SubscriptionRemainingCarsUpdateByAdminResponse::class,
            $subscriptionDetailsResult);
    }
}
