<?php

namespace App\Request\User;

class UserPasswordUpdateBySuperAdminRequest
{
    private int $id;

    private string $password;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getPassword(): ?string
    {
        return $this->password;
    }
}
