<?php

namespace App\Request\Verification;

class VerificationCodeResendRequest
{
    private string $userId;

    public function getUserId(): string
    {
        return $this->userId;
    }
}
