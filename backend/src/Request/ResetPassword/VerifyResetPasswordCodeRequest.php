<?php

namespace App\Request\ResetPassword;

class VerifyResetPasswordCodeRequest
{
    private string $code;

    public function getCode(): string
    {
        return $this->code;
    }
}
