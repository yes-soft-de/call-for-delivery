<?php

namespace App\Constant\UserStatus;

final class UserStatusConstant
{
    // status field take this when a new user is registered
    const USER_STATUS_ACTIVATED = "activated";

    // when user is in maintenance mood then its account is deactivated
    const USER_STATUS_MAINTENANCE_MOOD = "maintenanceMood";

    //const USER_STATUS_DELETED = "deleted";

    const WRONG_USER_STATUS = "wrongUserStatus";
}
