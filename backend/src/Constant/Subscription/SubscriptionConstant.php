<?php

namespace App\Constant\Subscription;

final class SubscriptionConstant
{
    const ERROR = "error";
    
    const SUBSCRIBE_ACTIVE = "active";

    const SUBSCRIBE_INACTIVE = "inactive";

    const SUBSCRIBE_CURRENT = "yes";

    const SUBSCRIBE_NOT_CURRENT = "no";
   
    const CARS_FINISHED = "cars finished";

    const ORDERS_FINISHED = "order finished";

    const DATE_FINISHED = "date finished";

    const UPDATE_STATE = "updated";

    const UNSUBSCRIBED = "unsubscribed";

    const YOU_HAVE_SUBSCRIBED = "You have already subscribed";

    const YOU_DO_NOT_HAVE_SUBSCRIBED = "You do not have a subscription";

    const NEW_SUBSCRIPTION_ACTIVATED = "New subscription activated";
    
    const SUBSCRIPTION_OK = "Ok";

    const SUBSCRIPTION_EXTRA_TIME = "تم تمديد الباقة";

    const IS_FUTURE_TRUE = true;

    const IS_FUTURE_FALSE = false;
    
    const CAN_CREATE_ORDER = true;

    const CAN_NOT_CREATE_ORDER = false;

    const CAN_NOT_CREATE_CAPTAIN_OFFER = false;
   
    const IS_HAS_EXTRA_TRUE = true;
   
    const IS_HAS_EXTRA_FALSE = false;
    
    const POSSIBLE_TO_EXTRA_TRUE = true;

    const POSSIBLE_TO_EXTRA_FALSE = false;

    const NOT_POSSIBLE = "not possible to extra the subscription";

    const SUBSCRIPTION_NOT_FOUND = "subscription not found";

    const SUBSCRIPTION_NOT_EXTRA = "this subscription not extra";

    const CAN_SUBSCRIPTION_EXTRA_TRUE = true;
    
    const CAN_SUBSCRIPTION_EXTRA_FALSE = false;

    const PERCENT = "%";   

    const OPERATION_TYPE_ADDITION = "addition";

    const OPERATION_TYPE_SUBTRACTION = "subtraction";   

    const CAN_NOT_CREATE_SUB_ORDER = "canNotCreateSubOrder";

    const CARS_FINISHED_INT = 0;

    const SUBSCRIBE_CURRENT_BOOLEAN = 1;

    const SUBSCRIBE_NOT_CURRENT_BOOLEAN = 0;

    const OLD_STORE_SUBSCRIPTION = 30;

    const WRONG_SUBSCRIPTION_UPDATE_OPERATION_CONST = 134;

    const SUBSCRIPTION_DATE_IS_VALID_CONST = 135;

    const SUBSCRIPTION_DATE_IS_FINISHED_CONST = 141;

    const SUBSCRIPTION_REMAINING_ORDERS_AND_DATE_ARE_VALID_CONST = 148;

    const FUTURE_SUBSCRIPTION_DOES_NOT_EXIST_CONST = 149;

    const SUBSCRIPTION_DOES_NOT_EXIST_CONST = 150;
}
