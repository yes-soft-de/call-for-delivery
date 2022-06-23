<?php

namespace App\Response\Admin\Order;

use DateTime;

class OrderCreateByAdminResponse
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
     * @var string|null $note
     */
    public $note;

    public DateTime $deliveryDate;

    public DateTime $createdAt;

    /**
     * @var DateTime|null
     */
    public $updatedAt;

    /**
     * @var float|null
     */
    public $kilometer;

    /**
     * @var string|null $recipientName
     */
    public $recipientName;

    /**
     * @var string|null $recipientPhone
     */
    public $recipientPhone;

    /**
     * @var string|null $detail
     */
    public $detail;

    /**
     * @var int|null $detail
     */
    public $paidToProvider;
}
