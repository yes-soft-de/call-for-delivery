<?php

namespace App\Constant\Order;

final class OrderStateConstant
{
    const ORDER_STATE_NOT_PAID = "not paid";

    const ORDER_STATE_PENDING = "pending";

    const ORDER_STATE_ON_WAY = "on way to pick order";

    const ORDER_STATE_IN_STORE= "in store";

    const ORDER_STATE_PICKED= "picked";

    const ORDER_STATE_ONGOING= "ongoing";

    const ORDER_STATE_DELIVERED= "delivered";

    const ORDER_STATE_CANCEL= "cancelled";
}