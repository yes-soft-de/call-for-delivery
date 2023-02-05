<?php

namespace App\Response\Order\Destination;

use DateTime;

class OrderDestinationUpdateResponse
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

    public DateTime $deliveryDate;

    public DateTime $createdAt;

    /**
     * @var int|null
     */
    public $paidToProvider;

    /**
     * @var bool|null
     */
    public $orderIsMain;

    /**
     * @var string|null
     */
    public $storeBranchToClientDistanceAdditionExplanation;
}
