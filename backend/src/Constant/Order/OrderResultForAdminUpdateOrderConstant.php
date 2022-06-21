<?php

namespace App\Constant\Order;

final class OrderResultForAdminUpdateOrderConstant
{
    const ERROR_UPDATE_BRANCH = "captain is in store,You can't modify the branch";
   
    const ERROR_UPDATE_CAPTAIN_ONGOING = "captain is ongoing,You can't modify detail or destination or deliveryDate";

}