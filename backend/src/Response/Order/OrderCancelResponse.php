<?php

namespace App\Response\Order;

class OrderCancelResponse
{
    public int $id;

    public null|string $state;

    public null|string $statusError;
}
