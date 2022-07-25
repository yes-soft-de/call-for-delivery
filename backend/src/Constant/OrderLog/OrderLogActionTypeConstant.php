<?php

namespace App\Constant\OrderLog;

/**
 * // This class holds the constants which refers to the types of actions which may be applied to an order
 */
class OrderLogActionTypeConstant
{
    const CREATE_ORDER_BY_STORE_ACTION_CONST = 1;

    const UPDATE_ORDER_BY_STORE_ACTION_CONST = 2;

    const CONFIRM_CAPTAIN_ARRIVAL_BY_STORE_ACTION_CONST = 5;

    const HIDE_ORDER_EXCEEDED_DELIVERY_TIME_ACTION_CONST = 6;

    const SHOW_SUB_ORDER_IF_CAR_AVAILABLE_ACTION_CONST = 7;

    const UPDATE_STATUS_BY_CAPTAIN_ACTION_CONST = 14;

    const UPDATE_PAID_TO_PROVIDER_BY_CAPTAIN_ACTION_CONST = 16;

    //const CONFIRM_CAPTAIN_ARRIVAL_ACTION_TYPE_CONST = 4;
}
