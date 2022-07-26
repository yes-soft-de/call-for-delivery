<?php

namespace App\Service\Admin\OrderLog;

use App\AutoMapping;
use App\Manager\OrderLog\OrderLogManager;
use App\Response\Admin\OrderLog\OrderLogByOrderIdGetForAdminResponse;

class AdminOrderLogService
{
    private AutoMapping $autoMapping;
    private OrderLogManager $orderLogManager;

    public function __construct(AutoMapping $autoMapping, OrderLogManager $orderLogManager)
    {
        $this->autoMapping = $autoMapping;
        $this->orderLogManager = $orderLogManager;
    }

    public function getOrderLogsByOrderIdForAdmin(int $orderId): array
    {
        $response = [];

        $orderLogs = $this->orderLogManager->getOrderLogsByOrderIdForAdmin($orderId);

        if (count($orderLogs) !== 0) {
            foreach ($orderLogs as $orderLog) {
                $response[] = $this->autoMapping->map('array', OrderLogByOrderIdGetForAdminResponse::class, $orderLog);
            }
        }

        return $response;
    }
}
