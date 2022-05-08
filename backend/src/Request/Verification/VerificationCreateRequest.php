<?php

namespace App\Request\Verification;

use App\Entity\UserEntity;

class VerificationCreateRequest
{
    /**
     * @var UserEntity
     */
    private $user;

    /**
     * @var string|null
     */
    private $code;

    public function getUser(): UserEntity
    {
        return $this->user;
    }

    public function setUser(UserEntity $user): void
    {
        $this->user = $user;
    }

    public function setCode(?string $code): void
    {
        $this->code = $code;
    }
}
