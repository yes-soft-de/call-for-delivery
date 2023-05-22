<?php

namespace App\Request\Admin\Order;

class OrderStoreBranchToClientDistanceUpdateByAddAdditionalDistanceByAdminRequest
{
    private int $orderId;

    private float $additionalDistance;

    /**
     * @var string|null
     */
    private $storeBranchToClientDistanceAdditionExplanation;

    private string $adminNote;

    public function getOrderId(): int
    {
        return $this->orderId;
    }

    public function getAdditionalDistance(): float
    {
        return $this->additionalDistance;
    }

    public function getStoreBranchToClientDistanceAdditionExplanation(): ?string
    {
        return $this->storeBranchToClientDistanceAdditionExplanation;
    }
}
