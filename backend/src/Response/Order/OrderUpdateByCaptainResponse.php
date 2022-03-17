<?php

namespace App\Response\Order;

class OrderUpdateByCaptainResponse
{
    public int $id;

    public string $state;

    public int|null $kilometer;
}
