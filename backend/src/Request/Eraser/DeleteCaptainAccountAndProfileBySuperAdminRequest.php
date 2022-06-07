<?php

namespace App\Request\Eraser;

class DeleteCaptainAccountAndProfileBySuperAdminRequest
{
    private int $id; // id of the user record

    private string $password; // for securing deletion

    public function getId(): int
    {
        return $this->id;
    }

    public function getPassword(): string
    {
        return $this->password;
    }
}
