<?php

namespace App\Service\Order;

use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Manager\Order\OrderManager;
use App\Request\Order\OrderFilterRequest;
use App\Request\Order\OrderCreateRequest;
use App\Response\Order\OrderResponse;
use App\Response\Order\OrdersResponse;
use App\Response\Order\OrderClosestResponse;
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

class OrderService
{
    private AutoMapping $autoMapping;
    private OrderManager $orderManager;
    private SubscriptionService $subscriptionService;
    private NotificationLocalService $notificationLocalService;
    private UploadFileHelperService $uploadFileHelperService;
    private CaptainService $captainService;

    public function __construct(AutoMapping $autoMapping, OrderManager $orderManager, SubscriptionService $subscriptionService, NotificationLocalService $notificationLocalService, UploadFileHelperService $uploadFileHelperService, CaptainService $captainService)
    {
       $this->autoMapping = $autoMapping;
       $this->orderManager = $orderManager;
       $this->subscriptionService = $subscriptionService;
       $this->notificationLocalService = $notificationLocalService;
       $this->uploadFileHelperService = $uploadFileHelperService;
       $this->captainService = $captainService;
    }

    /**
     * @param OrderCreateRequest $request
     * @return OrderResponse|CanCreateOrderResponse
     */
    public function createOrder(OrderCreateRequest $request): OrderResponse|CanCreateOrderResponse
    {
        $canCreateOrder = $this->subscriptionService->canCreateOrder($request->getStoreOwner()); 
     
        if($canCreateOrder->canCreateOrder === SubscriptionConstant::CAN_NOT_CREATE_ORDER) {
      
            return  $canCreateOrder;
        }

        $order = $this->orderManager->createOrder($request);
        if($order) {
        
            $this->subscriptionService->updateRemainingOrders($request->getStoreOwner()->getStoreOwnerId());
 
            $this->notificationLocalService->createNotificationLocal($request->getStoreOwner()->getStoreOwnerId(), NotificationConstant::NEW_ORDER_TITLE, NotificationConstant::CREATE_ORDER_SUCCESS, $order->getId());
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
            
            $order['images'] = $this->uploadFileHelperService->getImageParams($order['imagePath']);

            // following statement is a temporary one
            $order['captainUserId'] = $id;
            //This is for testing, it will be completed after building the captain's entity
            $order['roomId'] = "12345678912456789";
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

        $orders = $this->orderManager->closestOrders();

        foreach ($orders as $order) {

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

    public function getSpecificOrderForCaptain(int $id): ?SpecificOrderForCaptainResponse
    {
        $order = $this->orderManager->getSpecificOrderForCaptain($id);
        if($order) {
            
            $order['images'] = $this->uploadFileHelperService->getImageParams($order['imagePath']);

            //TODO change this
            $order['roomId'] = "12345678912456789";
        }

        return $this->autoMapping->map("array", SpecificOrderForCaptainResponse::class, $order);
    }

}
