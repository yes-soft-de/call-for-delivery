<?php

namespace App\Constant\Order;

final class OrderStateConstant
{
    const ORDER_STATE_NOT_PAID = "not paid";

    /**
     * this is the first status of the bid order, not pending
     * when a price offer is accepted, then the status of the bid order become pending
     */
    const ORDER_STATE_INITIALIZED = "initialized";

    const ORDER_STATE_PENDING = "pending";

    const ORDER_STATE_ON_WAY = "on way to pick order";

    const ORDER_STATE_IN_STORE= "in store";

    const ORDER_STATE_PICKED= "picked";

    const ORDER_STATE_ONGOING= "ongoing";

    const ORDER_STATE_DELIVERED= "delivered";

    const ORDER_STATE_CANCEL= "cancelled";

    const ORDER_STATE_ONGOING_FILTER_ARRAY = ["ongoing", "on way to pick order", "in store", "picked"];

    const ORDER_STATE_PENDING_INT = 1;

    const ORDER_STATE_ARRAY_INT = [
        self::ORDER_STATE_PENDING => 1,
        self::ORDER_STATE_ON_WAY => 2,
        self::ORDER_STATE_IN_STORE => 3,
        self::ORDER_STATE_PICKED => 4,
        self::ORDER_STATE_ONGOING => 5,
        self::ORDER_STATE_DELIVERED => 6,
        self::ORDER_STATE_CANCEL => 7
    ];
}