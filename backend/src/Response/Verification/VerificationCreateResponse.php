<?php

namespace App\Response\Verification;

use DateTime;

class VerificationCreateResponse
{
    public DateTime $createdAt;

    public string $smsMessageStatus;
}
