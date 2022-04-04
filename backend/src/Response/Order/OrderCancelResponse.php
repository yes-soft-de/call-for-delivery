<?php

namespace App\Response\Order;

class OrderCancelResponse
{
    public int $id;

    public string $state;

    public string $statusError;
}
