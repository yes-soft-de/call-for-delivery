<?php

namespace App\Constant\Order;

final class OrderIsHideConstant
{
    //the order is sub order, hidden from orders closest for the captains
    const ORDER_HIDE = 1;
    //the order is sub order, show in orders closest for the captains
    const ORDER_SHOW = 2;
    //the order is sub order, Temporarily hidden from orders closest for the captains, until a car is available
    const ORDER_HIDE_TEMPORARILY = 3;
}