<?php

namespace App\Response\Order;

class OrderDeliveryCostUpdateResponse
{
    public int $id;

    /**
     * @var float|null
     */
    public $deliveryCost;
}
