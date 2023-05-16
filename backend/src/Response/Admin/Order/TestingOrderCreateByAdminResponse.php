<?php

namespace App\Response\Admin\Order;

use DateTime;

class TestingOrderCreateByAdminResponse
{
    public int $id;

    public string $state;

    public string $payment;

    /**
     * @var float|null
     */
    public $orderCost;

    public int $orderType;

    public DateTime $deliveryDate;

    public DateTime $createdAt;

    /**
     * @var string|null $recipientName
     */
    public $recipientName;

    /**
     * @var string|null $recipientPhone
     */
    public $recipientPhone;
}
