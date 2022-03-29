<?php

namespace App\Response\OrderLogs;

use App\Entity\OrderEntity;

class OrderLogsResponse
{
    public int $id;

    public OrderEntity $orderId;

    public object $createdAt;

    public string $orderState;
}
