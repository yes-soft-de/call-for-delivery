<?php

namespace App\Request\Admin\User;

class UserIdUpdateRequest
{
    private string $currentUserId;

    private string $newUserId;

    // this just for protect the API
    private string $password;

    public function getCurrentUserId(): string
    {
        return $this->currentUserId;
    }

    public function getNewUserId(): string
    {
        return $this->newUserId;
    }

    public function getPassword(): string
    {
        return $this->password;
    }
}
