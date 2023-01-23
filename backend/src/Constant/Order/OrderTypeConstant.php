<?php

namespace App\Constant\Order;

final class OrderTypeConstant
{
    const ORDER_TYPE_NORMAL = 1;

    const ORDER_TYPE_BID = 2;
   
    const ORDER_PAYMENT_CARD = "card";
   
    const ORDER_PAYMENT_CASH= "cash";

    const ORDER_PAID_TO_PROVIDER_YES = 1;

    const ORDER_PAID_TO_PROVIDER_NO = 2;

    const ORDER_PAID_TO_PROVIDER_PARTIALLY= 3;

    const ORDER_TYPE_WRONG_CONST = 156;
}
