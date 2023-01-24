<?php

namespace App\Request\Order;

class OrderStoreBranchToClientDistanceUpdateRequest
{
    private int $id;

    private float $storeBranchToClientDistance;

    /**
     * @var string|null
     */
    private $storeBranchToClientDistanceAdditionExplanation;

    public function getId(): int
    {
        return $this->id;
    }

    public function setId(int $id): void
    {
        $this->id = $id;
    }

    public function getStoreBranchToClientDistance(): float
    {
        return $this->storeBranchToClientDistance;
    }

    public function setStoreBranchToClientDistance(float $storeBranchToClientDistance): void
    {
        $this->storeBranchToClientDistance = $storeBranchToClientDistance;
    }

    public function getStoreBranchToClientDistanceAdditionExplanation(): ?string
    {
        return $this->storeBranchToClientDistanceAdditionExplanation;
    }

    public function setStoreBranchToClientDistanceAdditionExplanation(?string $storeBranchToClientDistanceAdditionExplanation): void
    {
        $this->storeBranchToClientDistanceAdditionExplanation = $storeBranchToClientDistanceAdditionExplanation;
    }
}
