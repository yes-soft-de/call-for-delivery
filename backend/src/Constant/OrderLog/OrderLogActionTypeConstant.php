<?php

namespace App\Constant\OrderLog;

/**
 * // This class holds the constants which refers to the types of actions which may be applied to an order
 */
final class OrderLogActionTypeConstant
{
    const CREATE_ORDER_BY_STORE_ACTION_CONST = 1;

    const UPDATE_ORDER_BY_STORE_ACTION_CONST = 2;

    const CANCEL_ORDER_BY_STORE_ACTION_CONST = 3;

    const RECYCLE_ORDER_BY_STORE_ACTION_CONST = 4;

    const CONFIRM_CAPTAIN_ARRIVAL_BY_STORE_ACTION_CONST = 5;

    const HIDE_ORDER_EXCEEDED_DELIVERY_TIME_ACTION_CONST = 6;

    const SHOW_SUB_ORDER_IF_CAR_AVAILABLE_ACTION_CONST = 7;

    const CREATE_SUB_ORDER_BY_STORE_ACTION_CONST = 8;

    const UN_LINK_SUB_ORDER_BY_STORE_ACTION_CONST = 9;

    const HIDE_ORDER_WHILE_UPDATING_BY_STORE_ACTION_CONST = 10;

    const UN_ASSIGN_ORDER_TO_CAPTAIN_BY_ADMIN_ACTION_CONST = 11;

    const HIDE_ORDER_WHILE_UPDATING_BY_ADMIN_ACTION_CONST = 12;

    const UPDATE_ORDER_BY_ADMIN_ACTION_CONST = 13;

    const UPDATE_ORDER_STATE_BY_CAPTAIN_ACTION_CONST = 14;

    const UN_LINK_SUB_ORDER_BY_CAPTAIN_ACTION_CONST = 15;

    const UPDATE_PAID_TO_PROVIDER_BY_CAPTAIN_ACTION_CONST = 16;

    const CREATE_ORDER_BY_ADMIN_ACTION_CONST = 17;

    const ASSIGN_ORDER_TO_CAPTAIN_BY_ADMIN_ACTION_CONST = 18;

    const CANCEL_ORDER_BY_ADMIN_ACTION_CONST = 19;

    const UPDATE_ORDER_STATE_BY_ADMIN_ACTION_CONST = 20;

    const CONFIRM_CAPTAIN_PAID_TO_PROVIDER_BY_STORE_ACTION_CONST = 21;

    const CREATE_SUB_ORDER_BY_ADMIN_ACTION_CONST = 22;

    const UPDATE_STORE_BRANCH_TO_CLIENT_DISTANCE_BY_ADMIN_ACTION_CONST = 23;

    const UPDATE_STORE_BRANCH_TO_CLIENT_DISTANCE_AND_DESTINATION_BY_ADMIN_ACTION_CONST = 24;

    const UPDATE_IS_CASH_PAYMENT_CONFIRMED_BY_STORE_VIA_COMMAND = 25;

    const UPDATE_HAS_PAY_CONFLICT_ANSWERS_VIA_COMMAND = 26;

    const ORDER_CONFLICTED_ANSWERS_RESOLVED_BY_ADMIN_CONST = 27;

    const CONFIRM_CAPTAIN_PAID_TO_PROVIDER_BY_STORE_VIA_DASHBOARD_CONST = 28;

    const UPDATE_ORDER_DESTINATION_BY_ADMIN_ACTION_CONST = 29;

    const UPDATE_STORE_BRANCH_TO_CLIENT_DISTANCE_VIA_ADDING_DISTANCE_BY_ADMIN_ACTION_CONST = 30;

    const UPDATE_STORE_BRANCH_TO_CLIENT_DISTANCE_VIA_ADD_ADDITIONAL_DISTANCE_BY_ADMIN_ACTION_CONST = 31;

    const RECYCLE_ORDER_BY_ADMIN_ACTION_CONST = 32;

    // order destination had been saved in order to be replaced by a new one
    const ORDER_OLD_DESTINATION_SAVED_CONST = 33;

    // order destination had been updated by captain
    // const NORMAL_ORDER_DESTINATION_ADDITION_BY_CAPTAIN_CONST = 34;

    const UN_ASSIGN_ORDER_TO_CAPTAIN_BY_CAPTAIN_ACTION_CONST = 35;
}
