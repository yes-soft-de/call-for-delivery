<?php

namespace App\Response\Verification;

use DateTime;

class VerificationCodeGetResponse
{
    public int $id;

    public string $userId;

    public bool $verificationStatus;

    public array $roles;

    public string $code;

    public DateTime $createdAt;
}
