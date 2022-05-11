<?php

namespace App\Request\ResetPassword;

class ResetPasswordOrderCreateRequest
{
    private string $userId;

    private string $code;

    private string $role;

    public function getUserId(): string
    {
        return $this->userId;
    }

    public function setCode(string $code): void
    {
        $this->code = $code;
    }

    public function getRole(): string
    {
        return $this->role;
    }
}
