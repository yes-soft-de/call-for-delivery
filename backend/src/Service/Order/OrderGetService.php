<?php

namespace App\Service\Order;

use App\Constant\Order\OrderResultConstant;
use App\Entity\OrderEntity;
use App\Manager\Order\OrderManager;

class OrderGetService
{
    public function __construct(
        private OrderManager $orderManager
    )
    {
    }

    public function getOrderEntityByIdAndState(int $orderId, string $orderState): OrderEntity|string
    {
        $order = $this->orderManager->getOrderEntityByIdAndState($orderId, $orderState);

        if (! $order) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        return $order;
    }
}
