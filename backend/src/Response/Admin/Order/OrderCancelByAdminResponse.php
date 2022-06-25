<?php

namespace App\Response\Admin\Order;

class OrderCancelByAdminResponse
{
    public int $id;

    public string $state;

    /**
     * @var string|null
     */
    public $statusError;
}
