<?php

namespace App\Constant\Order;

final class OrderDestinationConstant
{
    /* Order receiver destination constants */

    // current receiver location is correct
    const ORDER_DESTINATION_IS_NOT_DIFFERENT_CONST = 1;

    // current receiver location had been updated by the captain because it differentiate from the old one
    const ORDER_DESTINATION_IS_DIFFERENT_AND_UPDATED_BY_CAPTAIN_CONST = 2;

    // current receiver location had been updated by the captain, and the admin agreed on the update procedure
    const ORDER_DESTINATION_IS_DIFFERENT_AND_AGREED_BY_ADMIN_CONST = 3;

    // current receiver location had been updated by an admin
    const ORDER_DESTINATION_IS_DIFFERENT_AND_UPDATED_BY_ADMIN_CONST = 4;
}
