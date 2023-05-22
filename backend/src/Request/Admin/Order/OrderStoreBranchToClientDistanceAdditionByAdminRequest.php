<?php

namespace App\Request\Admin\Order;

class OrderStoreBranchToClientDistanceAdditionByAdminRequest
{
    private int $orderId;

    private array $destination;

    /**
     * @var string|null
     */
    private $storeBranchToClientDistanceAdditionExplanation;

    private string $adminNote;

    public function getOrderId(): int
    {
        return $this->orderId;
    }

    public function setOrderId(int $orderId): void
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

    public function getStoreBranchToClientDistanceAdditionExplanation(): ?string
    {
        return $this->storeBranchToClientDistanceAdditionExplanation;
    }
}
