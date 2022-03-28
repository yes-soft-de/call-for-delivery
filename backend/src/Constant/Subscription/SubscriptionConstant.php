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

    const SUBSCRIPTION_FOUND = "subscription found";

    const CONSUMED_LESS_THAN_20_PERCENT = "less than 20 %";

    const CONSUMED_LESS_THAN_50_PERCENT = "less than 50 %";
    
    const CONSUMED_LESS_THAN_80_PERCENT = "less than 80 %";

    const CONSUMED_100_PERCENT = "100 %";

    const CONSUMED_0_PERCENT = "0 %";

    const CONSUMED_MORE_THAN_80_PERCENT = "more than 80 %";
}
