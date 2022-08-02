<?php

namespace App\Constant\Order;

final class OrderAmountCashConstant
{
    const ORDER_PAID_FLAG_YES = 1;

    const ORDER_PAID_FLAG_NO = 2;

    const NOT_ORDER_CASH = "error not orders cash";
    
    const CAPTAIN_NOT_ALLOWED_TO_EDIT_ORDER_PAID_FLAG = false;

    const CAPTAIN_NOT_ALLOWED_TO_EDIT_ORDER_PAID_FLAG_STRING = "not allowed update";
}