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
}
