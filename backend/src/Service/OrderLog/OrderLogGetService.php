<?php

namespace App\Service\OrderLog;

use App\Constant\OrderLog\OrderLogResultConstant;
use App\Manager\OrderLog\OrderLogManager;

class OrderLogGetService
{
    private OrderLogManager $orderLogManager;

    public function __construct(OrderLogManager $orderLogManager)
    {
        $this->orderLogManager = $orderLogManager;
    }

    public function getLastStateCreatedAtOrderLogByOrderIdAndTypeAndActionAndCreatedByUserType(int $orderId, int $orderType, int $actions, int $createdByUserType): \DateTimeInterface|int
    {
        $orderLog = $this->orderLogManager->getOrderLogByOrderIdAndTypeAndActionAndCreatedUserType($orderId, $orderType,
            $actions, $createdByUserType);

        if (! $orderLog) {
            return OrderLogResultConstant::ORDER_LOG_NOT_EXIST_CONST;
        }

        return $orderLog->getCreatedAt();
    }
}
