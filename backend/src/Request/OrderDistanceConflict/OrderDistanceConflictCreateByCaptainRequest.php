<?php

namespace App\Request\OrderDistanceConflict;

use App\Entity\OrderEntity;

class OrderDistanceConflictCreateByCaptainRequest
{
    /**
     * @var int|OrderEntity
     */
    private $orderId;

    /**
     * user profile id
     *
     * @var int|null
     */
    private $conflictIssuedBy;

    private string $conflictNote;

    // the proposed destination or kilometers by the user who create the conflict
    private string $proposedDestinationOrDistance;

    /**
     * @var float|null
     */
    private $oldDistance;

    /**
     * @var float|null
     */
    private $newDistance;

    private array $oldDestination = [];

    public function getOrderId(): OrderEntity|int
    {
        return $this->orderId;
    }

    public function setOrderId(OrderEntity|int $orderId): void
    {
        $this->orderId = $orderId;
    }

    public function setConflictIssuedBy(?int $conflictIssuedBy): void
    {
        $this->conflictIssuedBy = $conflictIssuedBy;
    }

    public function setOldDistance(?float $oldDistance): void
    {
        $this->oldDistance = $oldDistance;
    }

    public function setNewDistance(?float $newDistance): void
    {
        $this->newDistance = $newDistance;
    }

    public function setOldDestination(array $oldDestination): void
    {
        $this->oldDestination = $oldDestination;
    }
}
