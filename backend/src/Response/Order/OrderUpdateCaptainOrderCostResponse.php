<?php

namespace App\Response\Order;

class OrderUpdateCaptainOrderCostResponse
{
    public int $id;

    public float $captainOrderCost;

    public string|null $noteCaptainOrderCost;

    public string|null $attention;
}
