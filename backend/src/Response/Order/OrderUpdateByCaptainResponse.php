<?php

namespace App\Response\Order;

class OrderUpdateByCaptainResponse
{
    public int $id;

    public string $state;

    public float|null $kilometer;

    public float|null $captainOrderCost;

    public string|null $noteCaptainOrderCost;

    public int|null $paidToProvider;
}
