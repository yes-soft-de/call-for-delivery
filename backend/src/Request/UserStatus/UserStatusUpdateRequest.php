<?php

namespace App\Request\UserStatus;

class UserStatusUpdateRequest
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
