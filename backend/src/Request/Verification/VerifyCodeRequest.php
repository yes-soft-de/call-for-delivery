<?php

namespace App\Request\Verification;

use App\Entity\UserEntity;

class VerifyCodeRequest
{
    /**
     * @var UserEntity|int
     */
    private $user;

    private string $code;

    public function getUser(): UserEntity|int
    {
        return $this->user;
    }

    public function setUser(UserEntity|int $user): void
    {
        $this->user = $user;
    }

    public function getCode(): string
    {
        return $this->code;
    }
}
