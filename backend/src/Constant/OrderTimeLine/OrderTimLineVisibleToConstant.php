<?php

namespace App\Constant\OrderTimeLine;

final class OrderTimLineVisibleToConstant
{
    // order time line record will be visible to admin only
    const VISIBLE_TO_ADMIN_CONST = 1;

    // order time line record will be visible to all users
    const VISIBLE_TO_ALL_CONST = 2;

    const VISIBLE_TO_STORE_CONST = 3;

    const VISIBLE_TO_CAPTAIN_CONST = 4;

    const VISIBLE_TO_SUPPLIER_CONST = 5;
}
