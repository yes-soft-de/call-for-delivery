<?php

namespace App\Service\Order;

use App\AutoMapping;
use App\Constant\Order\OrderTypeConstant;
use App\Entity\DeliveryCarEntity;
use App\Entity\OrderEntity;
use App\Manager\Order\OrderManager;
use App\Request\Order\BidOrderFilterBySupplierRequest;
use App\Request\Order\BidDetailsCreateRequest;
use App\Request\Order\OrderFilterByCaptainRequest;
use App\Request\Order\OrderFilterRequest;
use App\Request\Order\OrderCreateRequest;
use App\Request\Order\OrderUpdateByCaptainRequest;
use App\Response\DeliveryCar\DeliveryCarGetForSupplierResponse;
use App\Response\Order\BidOrderForStoreOwnerGetResponse;
use App\Response\Order\OrderByIdForSupplierGetResponse;
use App\Response\Order\BidOrderFilterBySupplierResponse;
use App\Response\Order\FilterOrdersByCaptainResponse;
use App\Response\Order\OrderResponse;
use App\Response\Order\OrdersResponse;
use App\Response\Order\OrderClosestResponse;
use App\Response\Order\OrderUpdateByCaptainResponse;
use App\Response\Subscription\CanCreateOrderResponse;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Subscription\SubscriptionConstant;
use App\Service\Subscription\SubscriptionService;
use App\Service\Notification\NotificationLocalService;
use App\Service\Captain\CaptainService;
use App\Service\FileUpload\UploadFileHelperService;
use App\Constant\Captain\CaptainConstant;
use App\Response\Captain\CaptainStatusResponse;
use App\Response\Order\SpecificOrderForCaptainResponse;
use App\Constant\Order\OrderResultConstant;
use App\Constant\ChatRoom\ChatRoomConstant;
use App\Service\ChatRoom\OrderChatRoomService;
use App\Constant\Order\OrderStateConstant;
use App\Entity\OrderChatRoomEntity ;
use App\Request\Order\OrderUpdateCaptainOrderCostRequest;
use App\Response\Order\OrderUpdateCaptainOrderCostResponse;
use App\Constant\Order\OrderAttentionConstant;
use App\Request\Order\OrderUpdateCaptainArrivedRequest;
use App\Response\Order\OrderUpdateCaptainArrivedResponse;
use App\Service\OrderLogs\OrderLogsService;
use App\Service\Notification\NotificationFirebaseService;
use App\Response\Order\OrderCancelResponse;
use DateTime;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Service\CaptainFinancialSystem\CaptainFinancialDuesService;
use App\Service\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashService;
use App\Service\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersService;

class OrderService
{
    private AutoMapping $autoMapping;
    private OrderManager $orderManager;
    private SubscriptionService $subscriptionService;
    private NotificationLocalService $notificationLocalService;
    private UploadFileHelperService $uploadFileHelperService;
    private CaptainService $captainService;
    private OrderChatRoomService $orderChatRoomService;
    private OrderLogsService $orderLogsService;
    private NotificationFirebaseService $notificationFirebaseService;
    private CaptainFinancialDuesService $captainFinancialDuesService;
    private CaptainAmountFromOrderCashService $captainAmountFromOrderCashService;
    private StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService;

    public function __construct(AutoMapping $autoMapping, OrderManager $orderManager, SubscriptionService $subscriptionService, NotificationLocalService $notificationLocalService, UploadFileHelperService $uploadFileHelperService, CaptainService $captainService, OrderChatRoomService $orderChatRoomService, OrderLogsService $orderLogsService, NotificationFirebaseService $notificationFirebaseService, CaptainFinancialDuesService $captainFinancialDuesService, CaptainAmountFromOrderCashService $captainAmountFromOrderCashService, StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService)
    {
       $this->autoMapping = $autoMapping;
       $this->orderManager = $orderManager;
       $this->subscriptionService = $subscriptionService;
       $this->notificationLocalService = $notificationLocalService;
       $this->uploadFileHelperService = $uploadFileHelperService;
       $this->captainService = $captainService;
       $this->orderChatRoomService = $orderChatRoomService;
       $this->orderLogsService = $orderLogsService;
       $this->notificationFirebaseService = $notificationFirebaseService;
       $this->captainFinancialDuesService = $captainFinancialDuesService;
       $this->captainAmountFromOrderCashService = $captainAmountFromOrderCashService;
       $this->storeOwnerDuesFromCashOrdersService = $storeOwnerDuesFromCashOrdersService;
    }

    /**
     * @param OrderCreateRequest $request
     * @return OrderResponse|CanCreateOrderResponse
     */
    public function createOrder(OrderCreateRequest $request): OrderResponse|CanCreateOrderResponse|string 
    {        
        $canCreateOrder = $this->subscriptionService->canCreateOrder($request->getStoreOwner());
     
        if($canCreateOrder === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS || $canCreateOrder->canCreateOrder === SubscriptionConstant::CAN_NOT_CREATE_ORDER) {

            return  $canCreateOrder;
        }
        
        $order = $this->orderManager->createOrder($request);
        if($order) {
           
            $this->subscriptionService->updateRemainingOrders($request->getStoreOwner()->getStoreOwnerId(), SubscriptionConstant::OPERATION_TYPE_SUBTRACTION);
 
            $this->notificationLocalService->createNotificationLocal($request->getStoreOwner()->getStoreOwnerId(), NotificationConstant::NEW_ORDER_TITLE, NotificationConstant::CREATE_ORDER_SUCCESS, $order->getId());

            $this->orderLogsService->createOrderLogsRequest($order);
            //create firebase notification to store
             try{
                  $this->notificationFirebaseService->notificationOrderStateForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), $order->getState(), NotificationConstant::STORE);
                  }
             catch (\Exception $e){
                  error_log($e);
                }
             //create firebase notification to captains
             try{
                  $this->notificationFirebaseService->notificationToCaptains($order->getId());
                }
             catch (\Exception $e){
                    error_log($e);
                }
        }
        
        return $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $order);
    }

    public function createBidOrder(BidDetailsCreateRequest $request): OrderResponse|CanCreateOrderResponse|string
    {
        $canCreateOrder = $this->subscriptionService->getStoreOwnerProfileStatus($request->getStoreOwner());

        if($canCreateOrder === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS) {
            return $canCreateOrder;
        }

        $order = $this->orderManager->createBidOrder($request);

        if($order) {
            $this->notificationLocalService->createNotificationLocal($request->getStoreOwner()->getStoreOwnerId(), NotificationConstant::NEW_ANNOUNCEMENT_ORDER_TITLE,
                NotificationConstant::CREATE_ANNOUNCEMENT_ORDER_SUCCESS, $order->getId());

            $this->orderLogsService->createOrderLogsRequest($order);
            //create firebase notification to store
            try{
                $this->notificationFirebaseService->notificationOrderStateForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), $order->getState(), NotificationConstant::STORE);
            }
            catch (\Exception $e){
                error_log($e);
            }
            //create firebase notification to captains
            try{
                $this->notificationFirebaseService->notificationToCaptains($order->getId());
            }
            catch (\Exception $e){
                error_log($e);
            }
        }

        return $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $order);
    }

    /**
     * @param $userId
     * @return array
     */
    public function getStoreOrders(int $userId): ?array
    {
        $response = [];
       
        $orders = $this->orderManager->getStoreOrders($userId);
       
        foreach ($orders as $order) {
            $response[] = $this->autoMapping->map("array", OrdersResponse::class, $order);
        }

        return $response;
    }

    /**
     * @param $id
     * @return OrdersResponse
     */
    public function getSpecificOrderForStore(int $id): ?OrdersResponse
    {
        $order = $this->orderManager->getSpecificOrderForStore($id);
        if($order) {
            
            $order['attention'] = $order['noteCaptainOrderCost'];
            
            $order['images'] = $this->uploadFileHelperService->getImageParams($order['imagePath']);
            
            if($order['roomId']) {
                $order['roomId'] = $order['roomId']->toBase32();
            }
           
//            if($order['captainOrderCost']) {
//                if($order['orderCost'] !== $order['captainOrderCost']) {
//                        $order['attention'] = OrderAttentionConstant::ATTENTION_VALUE_NOT_MATCH;
//                 }
//                 else{
//                    $order['attention'] = OrderAttentionConstant::ATTENTION_VALUE_MATCH;
//                 }
//            }
         
            $order['orderLogs'] = $this->orderLogsService->getOrderLogsByOrderId($id);
        }
   
        return $this->autoMapping->map("array", OrdersResponse::class, $order);
    }

    public function filterStoreOrders(OrderFilterRequest $request, int $userId): ?array
    {
        $response = [];

        $orders = $this->orderManager->filterStoreOrders($request, $userId);

        foreach ($orders as $order) {
            $response[] = $this->autoMapping->map("array", OrdersResponse::class, $order);
        }

        return $response;
    }

    public function closestOrders($userId): array|CaptainStatusResponse
    {
       $captain = $this->captainService->captainIsActive($userId);
       if ($captain->status === CaptainConstant::CAPTAIN_INACTIVE) {

            return $this->autoMapping->map(CaptainStatusResponse::class ,CaptainStatusResponse::class, $captain);
        }

        $response = [];

        $orders = $this->orderManager->closestOrders($userId);

        foreach ($orders as $order) {
           
            if($order['roomId']) {
                $order['roomId'] = $order['roomId']->toBase32();
                $order['usedAs'] = $this->getUsedAs($order['usedAs']);
            }
            else {
                $order['usedAs'] = ChatRoomConstant::CHAT_ENQUIRE_NOT_USE;
            }

            $response[] = $this->autoMapping->map('array', OrderClosestResponse::class, $order);
        }

       return $response;
    }
    
    public function acceptedOrderByCaptainId($captainId): ?array
    {
        $response = [];

        $orders = $this->orderManager->acceptedOrderByCaptainId($captainId);

        foreach ($orders as $order) {
            
            $response[] = $this->autoMapping->map('array', OrderClosestResponse::class, $order);
        }

        return $response;
    }

    public function getSpecificOrderForCaptain(int $id, int $userId): ?SpecificOrderForCaptainResponse
    {
        $order = $this->orderManager->getSpecificOrderForCaptain($id, $userId);
        if($order) {
            
            $order['images'] = $this->uploadFileHelperService->getImageParams($order['imagePath']);
                      
            if($order['roomId']) {
                $order['roomId'] = $order['roomId']->toBase32();
                $order['usedAs'] = $this->getUsedAs($order['usedAs']);
            }
            else {
                $order['usedAs'] = ChatRoomConstant::CHAT_ENQUIRE_NOT_USE;
            }

            $order['orderLogs'] = $this->orderLogsService->getOrderLogsByOrderId($id);
        }

        return $this->autoMapping->map("array", SpecificOrderForCaptainResponse::class, $order);
    }

     public function orderUpdateStateByCaptain(OrderUpdateByCaptainRequest $request): OrderUpdateByCaptainResponse|string
    {
        if ($this->orderManager->getOrderTypeByOrderId($request->getId()) === OrderTypeConstant::ORDER_TYPE_NORMAL) {
            // Following if block will be executed only when the order is of type 1,
            // otherwise, we will mover to update statement directly
            if ($request->getState() === OrderStateConstant::ORDER_STATE_ON_WAY) {
                $canAcceptOrder = $this->subscriptionService->checkRemainingCarsByOrderId($request->getId());

                if ($canAcceptOrder === SubscriptionConstant::CARS_FINISHED) {
                    return $canAcceptOrder;
                }
            }
        }

        $order = $this->orderManager->orderUpdateStateByCaptain($request);
        
        if($order) {
            if( $order->getState() === OrderStateConstant::ORDER_STATE_ON_WAY) {
                $this->createOrderChatRoomOrUpdateCurrent($order);
            }
            
            if( $order->getState() === OrderStateConstant::ORDER_STATE_DELIVERED) {
                
                $this->captainFinancialDuesService->captainFinancialDues($request->getCaptainId()->getCaptainId());
              
                //Save the price of the order in cash in case the captain does not pay the store
                if( $order->getPayment() === OrderTypeConstant::ORDER_PAYMENT_CASH && $order->getPaidToProvider() === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
                    $this->captainAmountFromOrderCashService->createCaptainAmountFromOrderCash($order);
                    $this->storeOwnerDuesFromCashOrdersService->createStoreOwnerDuesFromCashOrders($order);
                }
            }

            //create Notification Local for store
            $this->notificationLocalService->createNotificationLocalForOrderState($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::STATE_TITLE, $order->getState(), $order->getId(), NotificationConstant::STORE, $order->getCaptainId()->getId()); 
            //create Notification Local for captain
            $this->notificationLocalService->createNotificationLocalForOrderState($order->getCaptainId()->getCaptainId(), NotificationConstant::STATE_TITLE, $order->getState(), $order->getId(), NotificationConstant::CAPTAIN); 
            //create order log
            $this->orderLogsService->createOrderLogsRequest($order);
            //create firebase notification to store
             try{
                $this->notificationFirebaseService->notificationOrderStateForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), $order->getState(), NotificationConstant::STORE);
              }
             catch (\Exception $e){
                  error_log($e);
              }
            // create firebase notification to captain
             try{
                $this->notificationFirebaseService->notificationOrderStateForUser($order->getCaptainId()->getCaptainId(), $order->getId(), $order->getState(), NotificationConstant::CAPTAIN);
              }
             catch (\Exception $e){
                  error_log($e);
              }
        }
     
        return $this->autoMapping->map(OrderEntity::class, OrderUpdateByCaptainResponse::class, $order);
    }

    public function getUsedAs($usedAs): string
     {   
        if($usedAs === ChatRoomConstant::CAPTAIN_STORE_ENQUIRE) {

           return ChatRoomConstant::CHAT_ENQUIRE_USE;
        }
        
        return ChatRoomConstant::CHAT_ENQUIRE_NOT_USE;
    }
    
    public function createOrderChatRoomOrUpdateCurrent(OrderEntity $order): ?OrderChatRoomEntity
    {     
        return $this->orderChatRoomService->createOrderChatRoomOrUpdateCurrent($order); 
    }

    public function filterOrdersByCaptain(OrderFilterByCaptainRequest $request): ?array
    {
        $response = [];

        $orders = $this->orderManager->filterOrdersByCaptain($request);

        foreach ($orders as $order) {
            $response[] = $this->autoMapping->map('array', FilterOrdersByCaptainResponse::class, $order);
        }

        return $response;
    }
    
    public function orderUpdateCaptainOrderCost(OrderUpdateCaptainOrderCostRequest $request): ?OrderUpdateCaptainOrderCostResponse
    {
        $order = $this->orderManager->orderUpdateCaptainOrderCost($request);

        $response = $this->autoMapping->map(OrderEntity::class, OrderUpdateCaptainOrderCostResponse::class, $order);
        
        if($order) {
            $response->attention = OrderAttentionConstant::ATTENTION;

            if($order->getOrderCost() !== $order->getCaptainOrderCost()) {
                $response->attention = OrderAttentionConstant::ATTENTION_VALUE_NOT_MATCH;
            }
        }

        return $response;
    }
    
    public function updateCaptainArrived(OrderUpdateCaptainArrivedRequest $request): ?OrderUpdateCaptainArrivedResponse
    {
        $order = $this->orderManager->updateCaptainArrived($request);
        
        if($order) {
            $this->orderLogsService->createOrderLogsRequest($order);
        }
     
        return $this->autoMapping->map(OrderEntity::class, OrderUpdateCaptainArrivedResponse::class, $order);
    }

    public function orderCancel(int $id): ?OrderCancelResponse
    {
        $order = $this->orderManager->getOrderById($id);
     
        if($order) {
            $halfHourLaterTime = date_modify($order->getCreatedAt(), '+30 minutes');

            $nowDate = new DateTime('now');
            
            if ( $halfHourLaterTime < $nowDate) {
               //create local notification to store
               $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::CANCEL_ORDER_TITLE, NotificationConstant::CANCEL_ORDER_ERROR_TIME, $order->getId());

               //create firebase notification to store
               try{
                    $this->notificationFirebaseService->notificationOrderStateForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), NotificationConstant::CANCEL_ORDER_ERROR_TIME, NotificationConstant::STORE);
                    }
               catch (\Exception $e){
                    error_log($e);
                }

               $order->statusError = OrderResultConstant::ORDER_NOT_REMOVE_TIME;
             
               return $this->autoMapping->map(OrderEntity::class, OrderCancelResponse::class, $order);
            }
            
            elseif ($order->getState() != OrderStateConstant::ORDER_STATE_PENDING) {
             
                //create local notification to store
                $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::CANCEL_ORDER_TITLE, NotificationConstant::CANCEL_ORDER_ERROR_ACCEPTED, $order->getId());

                //create firebase notification to store
                try{
                    $this->notificationFirebaseService->notificationOrderStateForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), NotificationConstant::CANCEL_ORDER_ERROR_ACCEPTED, NotificationConstant::STORE);
                    }
                catch (\Exception $e){
                    error_log($e);
                }
            
                $order->statusError = OrderResultConstant::ORDER_NOT_REMOVE_CAPTAIN_RECEIVED;
            
                return $this->autoMapping->map(OrderEntity::class, OrderCancelResponse::class, $order);
            }

            $order = $this->orderManager->orderCancel($order);

            if($order) {
           
                $this->orderLogsService->createOrderLogsRequest($order);

                //create local notification to store
                $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::CANCEL_ORDER_TITLE, NotificationConstant::CANCEL_ORDER_SUCCESS, $order->getId());

                //create firebase notification to store
                try{
                    $this->notificationFirebaseService->notificationOrderStateForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), NotificationConstant::CANCEL_ORDER_SUCCESS, NotificationConstant::STORE);
                    }
                catch (\Exception $e){
                    error_log($e);
                }
          
                $this->subscriptionService->updateRemainingOrders($order->getStoreOwner()->getStoreOwnerId(), SubscriptionConstant::OPERATION_TYPE_ADDITION);
            }
        }
     
        return $this->autoMapping->map(OrderEntity::class, OrderCancelResponse::class, $order);
    }

    public function getCountOrdersByCaptainId(int $captainId): array
    {
        return $this->orderManager->getCountOrdersByCaptainId($captainId);
    }  
    
    public function getDetailOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }   
    
    public function getCountOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderManager->getCountOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }
    
    public function getCountOrdersByFinancialSystemThree(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): array
    {
        return $this->orderManager->getCountOrdersByFinancialSystemThree($captainId, $fromDate, $toDate, $countKilometersFrom, $countKilometersTo);
    }

    // This function filter bid orders which the supplier had not provide a price offer for any one of them yet.
    public function filterBidOrdersBySupplier(BidOrderFilterBySupplierRequest $request): array
    {
        $response = [];

        $orders = $this->orderManager->filterBidOrdersBySupplier($request);

        if ($orders) {
            foreach ($orders as $order) {
                $response[] = $this->autoMapping->map("array", BidOrderFilterBySupplierResponse::class, $order);
            }
        }

        return $response;
    }

    public function getOrderByIdForSupplier(int $orderId, int $supplierId): OrderByIdForSupplierGetResponse|array
    {
        $response = [];

        $bidOrder = $this->orderManager->getOrderByIdForSupplier($orderId);

        if ($bidOrder) {
            $bidOrder['orderLogs'] = $this->orderLogsService->getOrderLogsByOrderId($bidOrder['id']);

            $bidOrder['bidDetailsId'] = $bidOrder['bidDetails']->getId();
            $bidOrder['bidDetailsImages'] = $this->customizeBidOrderImages($bidOrder['bidDetails']->getImages()->toArray());

            $bidOrder['pricesOffers'] = $this->filterAndCustomizePricesOffersAccordingToSupplier($bidOrder['bidDetails']->getPriceOfferEntities()->toArray(), $supplierId);

            $response = $this->autoMapping->map("array", OrderByIdForSupplierGetResponse::class, $bidOrder);
        }

        return $response;
    }

    // This function filter prices offers according to the supplier, and returns specific fields
    public function filterAndCustomizePricesOffersAccordingToSupplier(array $pricesOffersEntities, int $supplierId): ?array
    {
        if (! empty($pricesOffersEntities)) {
            $response = [];

            foreach ($pricesOffersEntities as $key=>$value) {
                if ($value->getSupplierProfile()->getUser()->getId() === $supplierId) {
                    // get delivery car info
                    $response[$key]['deliveryCar']['id'] = $value->getDeliveryCar()->getId();
                    $response[$key]['deliveryCar']['carModel'] = $value->getDeliveryCar()->getCarModel();
                    $response[$key]['deliveryCar']['details'] = $value->getDeliveryCar()->getDetails();
                    $response[$key]['deliveryCar']['deliveryCost'] = $value->getDeliveryCar()->getDeliveryCost();

                    // get price offer info
                    $response[$key]['priceOfferId'] = $value->getId();
                    $response[$key]['priceOfferValue'] = $value->getPriceOfferValue();
                    $response[$key]['priceOfferStatus'] = $value->getPriceOfferStatus();
                    $response[$key]['transportationCount'] = $value->getTransportationCount();
                    $response[$key]['offerDeadline'] = $value->getOfferDeadline();
                }
            }

            return $response;
        }

        return null;
    }

    public function customizeBidOrderImages(array $imagesArray): ?array
    {
        $response = [];

        if (! empty($imagesArray)) {
            foreach ($imagesArray as $image) {
                $response[] = $this->uploadFileHelperService->getImageParams($image->getImagePath());
            }

            return $response;

        } else {
            return null;
        }
    }

    // This function filter bid orders which have price offers made by the supplier (who request the filter).
    public function filterBidOrdersThatHavePriceOffersBySupplier(BidOrderFilterBySupplierRequest $request): array
    {
        $response = [];

        $orders = $this->orderManager->filterBidOrdersThatHavePriceOffersBySupplier($request);

        if ($orders) {
            // if the price offer status filter is set, then we have to filter the orders here in the Service layer
            if ($request->getPriceOfferStatus()) {
                $orders = $this->filterBidOrdersAccordingToLastPriceOfferStatus($orders, $request->getPriceOfferStatus());
            }

            foreach ($orders as $order) {
                $response[] = $this->autoMapping->map("array", BidOrderFilterBySupplierResponse::class, $order);
            }
        }

        return $response;
    }

    // This function filter the orders according to the last offer status of each order
    public function filterBidOrdersAccordingToLastPriceOfferStatus(array $bidOrders, string $priceOfferStatus): array
    {
        $response = [];

        foreach ($bidOrders as $bidOrder) {
            $pricesOffer = $this->orderManager->getLastPriceOfferByBidDetailsId($bidOrder['bidDetailsId']);

            if (! empty($pricesOffer)) {
                if ($pricesOffer['priceOfferStatus'] === $priceOfferStatus) {
                    $response[] = $bidOrder;
                }
            }
        }

        return $response;
    }

    public function getSpecificBidOrderForStore(int $id): ?BidOrderForStoreOwnerGetResponse
    {
        $order = $this->orderManager->getSpecificBidOrderForStore($id);

        if ($order) {
            $order['bidDetailsId'] = $order['bidDetails']->getId();
            $order['title'] = $order['bidDetails']->getTitle();
            $order['description'] = $order['bidDetails']->getDescription();
            $order['openToPriceOffer'] = $order['bidDetails']->getOpenToPriceOffer();

            $order['supplierCategoryId'] = $order['bidDetails']->getSupplierCategory()->getId();
            $order['supplierCategoryName'] = $order['bidDetails']->getSupplierCategory()->getName();

            $order['attention'] = $order['noteCaptainOrderCost'];

            $order['bidDetailsImages'] =  $this->customizeBidOrderImages($order['bidDetails']->getImages()->toArray());

            if($order['roomId']) {
                $order['roomId'] = $order['roomId']->toBase32();
            }

            $order['orderLogs'] = $this->orderLogsService->getOrderLogsByOrderId($id);
        }

        return $this->autoMapping->map("array", BidOrderForStoreOwnerGetResponse::class, $order);
    }
}
