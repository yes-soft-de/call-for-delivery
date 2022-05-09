<?php

namespace App\Request\User;

use App\Entity\UserEntity;

class UserVerificationStatusUpdateRequest
{
    /**
     * @var UserEntity|int
     */
    private $user;

    private int $verificationStatus;

    public function getUser(): UserEntity|int
    {
        return $this->user;
    }

    public function getVerificationStatus(): int
    {
        return $this->verificationStatus;
    }

    public function setVerificationStatus(int $verificationStatus): void
    {
        $this->verificationStatus = $verificationStatus;
    }
}
