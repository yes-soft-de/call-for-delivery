<?php

namespace App\Constant\User;

final class UserTypeConstant
{
    const USER_TYPE_MATCHED = "yes";

    const USER_TYPE_NOT_MATCHED = "no";

    // Following user types will be the one and basic user type values among all project
    const SUPER_ADMIN_USER_TYPE_CONST = 1;

    const ADMIN_USER_TYPE_CONST = 2;

    const STORE_OWNER_USER_TYPE_CONST = 3;

    const CAPTAIN_USER_TYPE_CONST = 4;

    const SUPPLIER_USER_TYPE_CONST = 5;
}
