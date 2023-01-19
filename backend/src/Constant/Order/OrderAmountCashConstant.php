<?php

namespace App\Constant\Order;

final class OrderAmountCashConstant
{
    const ORDER_PAID_FLAG_YES = 1;

    const ORDER_PAID_FLAG_NO = 2;

    const NOT_ORDER_CASH = "error not orders cash";
    
    const CAPTAIN_NOT_ALLOWED_TO_EDIT_ORDER_PAID_FLAG = false;

    const CAPTAIN_NOT_ALLOWED_TO_EDIT_ORDER_PAID_FLAG_STRING = 1;

    const CAPTAIN_AMOUNT_FROM_CASH_ORDER_NOT_EXIST_CONST = 127;

    const AMOUNT_ADDITION_TYPE_OPERATION_CONST = 128;

    const AMOUNT_SUBTRACTION_TYPE_OPERATION_CONST = 129;

    const STORE_DUES_FROM_CASH_ORDER_NOT_EXIST_CONST = 130;
}
