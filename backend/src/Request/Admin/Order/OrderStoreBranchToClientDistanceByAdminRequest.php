<?php

namespace App\Request\Admin\Order;

class OrderStoreBranchToClientDistanceByAdminRequest
{   
    private int $id;

    private float $storeBranchToClientDistance;

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
}
