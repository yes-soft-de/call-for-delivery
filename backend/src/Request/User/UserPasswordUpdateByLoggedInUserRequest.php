<?php

namespace App\Request\User;

class UserPasswordUpdateByLoggedInUserRequest
{
    // user record id
    private int $id;

    // The new password
    private string $password;

    public function getId(): int
    {
        return $this->id;
    }

    public function setId(int $id): void
    {
        $this->id = $id;
    }

    public function getPassword(): string
    {
        return $this->password;
    }
}
