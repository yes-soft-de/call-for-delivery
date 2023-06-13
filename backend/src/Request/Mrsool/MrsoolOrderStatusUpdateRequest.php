<?php

namespace App\Request\Mrsool;

class MrsoolOrderStatusUpdateRequest
{
    private int $id;

    private string $status;

    public function getId(): int
    {
        return $this->id;
    }

    public function setId(int $id): void
    {
        $this->id = $id;
    }

    public function getStatus(): string
    {
        return $this->status;
    }
}
