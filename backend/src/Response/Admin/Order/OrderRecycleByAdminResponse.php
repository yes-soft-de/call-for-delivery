<?php

namespace App\Response\Admin\Order;

class OrderRecycleByAdminResponse
{
    public int $id;

    public string $state;

    public string $payment;

    /**
     * @var float|null
     */
    public $orderCost;

    public int $orderType;

    /**
     * @var string|null
     */
    public $note;

    public \DateTime $deliveryDate;

    public \DateTime $createdAt;
}
