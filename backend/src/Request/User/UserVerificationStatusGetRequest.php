<?php

namespace App\Request\User;

class UserVerificationStatusGetRequest
{
    private string $userId;

    public function getUserId(): string
    {
        return $this->userId;
    }
}
