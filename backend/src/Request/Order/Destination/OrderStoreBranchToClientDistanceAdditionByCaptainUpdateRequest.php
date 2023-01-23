<?php

namespace App\Request\Order\Destination;

class OrderStoreBranchToClientDistanceAdditionByCaptainUpdateRequest
{
    // order id
    private int $id;

    /**
     * @var string|null
     */
    private $storeBranchToClientDistanceAdditionExplanation;

    // new client destination
    private array $destination;

    public function getId(): int
    {
        return $this->id;
    }

    public function getStoreBranchToClientDistanceAdditionExplanation(): ?string
    {
        return $this->storeBranchToClientDistanceAdditionExplanation;
    }

    public function getDestination(): array
    {
        return $this->destination;
    }
}
