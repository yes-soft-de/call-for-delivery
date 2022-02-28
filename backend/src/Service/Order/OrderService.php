<?php

namespace App\Service\Order;

use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Manager\Order\OrderManager;
use App\Request\Order\OrderCreateRequest;
use App\Response\Order\OrderResponse;

class OrderService
{
    public function __construct(private AutoMapping $autoMapping, private OrderManager $orderManager)
    {
    }

    /**
     * @param OrderCreateRequest $request
     * @return OrderResponse
     */
    public function createOrder(OrderCreateRequest $request): OrderResponse
    {
        $order = $this->orderManager->createOrder($request);

        return $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $order);
    }
}
