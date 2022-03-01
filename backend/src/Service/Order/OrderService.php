<?php

namespace App\Service\Order;

use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Manager\Order\OrderManager;
use App\Request\Order\OrderCreateRequest;
use App\Response\Order\OrderResponse;
use App\Response\Order\OrdersResponse;
use App\Response\Subscription\CanCreateOrderResponse;
use App\Constant\Subscription\SubscriptionConstant;
use App\Service\Subscription\SubscriptionService;

class OrderService
{
    public function __construct(private AutoMapping $autoMapping, private OrderManager $orderManager, private SubscriptionService $subscriptionService)
    {
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

         $this->subscriptionService->updateRemainingOrders($request->getStoreOwner());
        }
        return $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $order);
    }

    /**
     * @param $userId
     * @return array
     */
    public function getStoreOrders($userId): ?array
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
    public function getSpecificOrderForStore($id): ?OrdersResponse
    {
        $order = $this->orderManager->getSpecificOrderForStore($id);

        return $this->autoMapping->map("array", OrdersResponse::class, $order);
    }
}
