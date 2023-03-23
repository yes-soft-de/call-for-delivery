<?php

namespace App\Constant\Order;

final class OrderResultConstant
{
    const ORDER_NOT_FOUND_RESULT = "orderNotFound";

    const ORDER_NOT_REMOVE_TIME = "can not remove it, Exceeded time allowed";

    const ORDER_NOT_REMOVE_STATE = "on way to pick order";

    const ORDER_NOT_UPDATE_STATE = "you can't edit, The captain received the order";

    const ORDER_NOT_REMOVE_CAPTAIN_RECEIVED = "can not remove it, The captain received the order";

    const ORDER_ALREADY_IS_BEING_ACCEPTED = "orderAlreadyIsBeingAccepted";

    const ORDER_CAPTAIN_RECEIVED = "error, The captain received the order";

    const ORDER_TYPE_BID = "orderIsOfTypeBid";

    const ORDER_TYPE_IS_NOT_BID = "orderIsNotOfTypeBid";

    const ORDER_ACCEPTED_BY_CAPTAIN = "orderIsBeingAcceptedByCaptain";

    const ORDER_RETURNING_TO_PENDING_HAS_PROBLEM = "problemInReturningOrderToPendingStatus";

    const ERROR_UPDATE_BRANCH = "captain is in store,You can't modify the branch";
   
    const ERROR_UPDATE_CAPTAIN_ONGOING = "captain is ongoing,You can't modify detail or destination or deliveryDate";

    const ORDER_UPDATE_PROBLEM = "problemInUpdatingOrder";

    const ORDER_IS_BEING_DELIVERED = 1;

    const CAPTAIN_RECEIVED_ORDER_FOR_THIS_STORE_INT = 1;

    const CAPTAIN_NOT_RECEIVED_ORDER_FOR_THIS_STORE_INT = 0;

    const CAPTAIN_RECEIVED_ORDER_FOR_THIS_STORE = "the captain has received an order for a specific store";

    const CREATE_DATE_IS_GREATER_THAN_DELIVERY_DATE = "create time is greater than delivery time";

    const CAPTAIN_RECEIVED_ORDER_FOR_THIS_STORE_INT_FOR_ADMIN = 2;

    const ORDER_IS_HIDDEN_CONST = 21;

    const ORDER_UPDATE_STATE_NOT_ALLOWED_DUE_TO_SHORT_TIME_CONST = 22;

    const ORDER_CANCEL_NOT_ALLOWED_DUE_TO_WRONG_API = 35;

    const ORDER_ALREADY_BEING_CANCELLED = 36;

    const ORDER_DOES_NOT_BELONG_TO_SUBSCRIPTION = 38;

    const ORDER_IS_NOT_BEING_DELIVERED_YET_CONST = 154;

    const ORDER_IS_EITHER_ONGOING_OR_DELIVERED_CONST = 171;

    const ORDER_STATE_PENDING_CONST = 188;

    const ORDER_STATE_NOT_CORRECT_CONST = 189;
}
