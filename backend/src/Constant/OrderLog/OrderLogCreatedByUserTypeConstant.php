<?php

namespace App\Constant\OrderLog;

final class OrderLogCreatedByUserTypeConstant
{
    const SUPER_ADMIN_USER_TYPE_CONST = 1;

    const ADMIN_USER_TYPE_CONST = 2;

    const STORE_OWNER_USER_TYPE_CONST = 3;

    const CAPTAIN_USER_TYPE_CONST = 4;

    const SUPPLIER_USER_TYPE_CONST = 5;

    const USER_JOB_DESCRIPTION_ARRAY_CONST = [
        self::SUPPLIER_USER_TYPE_CONST => "المورد ",
        self::SUPER_ADMIN_USER_TYPE_CONST => "سوبر أدمن ",
        self::CAPTAIN_USER_TYPE_CONST => "الكابتن ",
        self::STORE_OWNER_USER_TYPE_CONST => "صاحب المتجر ",
        self::ADMIN_USER_TYPE_CONST => "المدير "
    ];
}
