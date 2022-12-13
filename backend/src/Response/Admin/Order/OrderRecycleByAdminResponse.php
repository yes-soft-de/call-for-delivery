<?php

namespace App\Response\Admin\Order;

class OrderRecycleByAdminResponse
{
    public int $id;

    public string $state;

    public string $payment;

    public float $orderCost;

    public int $orderType;

    /**
     * @var string|null
     */
    public $note;

    public \DateTime $deliveryDate;

    public \DateTime $createdAt;
}
