<?php

namespace App\Request\Order\Destination;

use App\Entity\OrderEntity;

class StoreOrderDetailsDifferentReceiverDestinationUpdateByOrderIdRequest
{
    /**
     * @var int|OrderEntity
     */
    private $orderId;

    private array $destination;

    private int $differentReceiverDestination;

    public function getOrderId(): OrderEntity|int
    {
        return $this->orderId;
    }

    public function setOrderId(OrderEntity|int $orderId): void
    {
        $this->orderId = $orderId;
    }

    public function getDestination(): array
    {
        return $this->destination;
    }

    public function setDestination(array $destination): void
    {
        $this->destination = $destination;
    }

    public function getDifferentReceiverDestination(): int
    {
        return $this->differentReceiverDestination;
    }

    public function setDifferentReceiverDestination(int $differentReceiverDestination): void
    {
        $this->differentReceiverDestination = $differentReceiverDestination;
    }
}
