<?php

namespace App\Request\User;

class UserFilterRequest
{
    private $userId;

    private $role;

    public function getUserId(): ?string
    {
        return $this->userId;
    }

    public function getRole(): ?string
    {
        return $this->role;
    }
}
