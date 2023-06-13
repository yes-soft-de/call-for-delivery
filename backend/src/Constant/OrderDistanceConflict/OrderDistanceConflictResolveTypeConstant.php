<?php

namespace App\Constant\OrderDistanceConflict;

class OrderDistanceConflictResolveTypeConstant
{
    // order distance conflict had been resolved by adding distance directly by admin to storeBranchToClientDistance
    const CONFLICT_RESOLVED_BY_DISTANCE_ADDITION_BY_ADMIN_CONST = 200;

    // order distance conflict had been resolved by updating destination by admin
    const CONFLICT_RESOLVED_BY_DESTINATION_UPDATE_BY_ADMIN_CONST = 201;

    // order distance conflict had been resolved by rejecting the conflict request by admin
    const CONFLICT_RESOLVED_BY_REJECTING_BY_ADMIN_CONST = 202;
}
