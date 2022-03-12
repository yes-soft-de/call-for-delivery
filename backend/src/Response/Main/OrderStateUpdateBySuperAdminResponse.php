<?php

namespace App\Response\Main;

use DateTime;

class OrderStateUpdateBySuperAdminResponse
{
    public int $id;

    public string $state;

    public string $payment;

    public float $orderCost;

    /**
     * @var int|null
     */
    public $captainId;

    public int $orderType;

    /**
     * @var string|null
     */
    public $note;

    public datetime $deliveryDate;

    public datetime $createdAt;

    /**
     * @var datetime|null
     */
    public $updatedAt;

    /**
     * @var int|null
     */
    public $kilometer;
}
