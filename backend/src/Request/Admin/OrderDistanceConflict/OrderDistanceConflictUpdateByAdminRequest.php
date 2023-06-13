<?php

namespace App\Request\Admin\OrderDistanceConflict;

use App\Entity\OrderEntity;
use DateTime;

class OrderDistanceConflictUpdateByAdminRequest
{
    /**
     * @var int|OrderEntity
     */
    private $orderId;

    private int $conflictResolvedBy;

    private string $adminNote;

    private DateTime $resolvedAt;

    private float $newDistance;

    /**
     * @var array|null
     */
    private $newDestination;

    private int $resolveType;

    public function getOrderId(): int|OrderEntity
    {
        return $this->orderId;
    }

    public function setOrderId(int|OrderEntity $orderId): void
    {
        $this->orderId = $orderId;
    }

    public function setConflictResolvedBy(int $conflictResolvedBy): void
    {
        $this->conflictResolvedBy = $conflictResolvedBy;
    }

    public function setAdminNote(string $adminNote): void
    {
        $this->adminNote = $adminNote;
    }

    public function setNewDistance(float $newDistance): void
    {
        $this->newDistance = $newDistance;
    }

    public function setNewDestination(?array $newDestination): void
    {
        $this->newDestination = $newDestination;
    }

    public function setResolveType(int $resolveType): void
    {
        $this->resolveType = $resolveType;
    }

    public function setResolvedAt(DateTime $resolvedAt): void
    {
        $this->resolvedAt = $resolvedAt;
    }
}
