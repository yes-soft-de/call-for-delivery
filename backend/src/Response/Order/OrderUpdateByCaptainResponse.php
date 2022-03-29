<?php

namespace App\Response\Order;

class OrderUpdateByCaptainResponse
{
    public int $id;

    public string $state;

    public int|null $kilometer;

    public float|null $captainOrderCost;

    public string|null $noteCaptainOrderCost;
}
