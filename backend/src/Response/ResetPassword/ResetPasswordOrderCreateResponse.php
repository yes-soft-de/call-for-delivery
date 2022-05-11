<?php

namespace App\Response\ResetPassword;

use DateTime;

class ResetPasswordOrderCreateResponse
{
    public DateTime $createdAt;

    /**
     * used when no user is found
     * @var string|null
     */
    public $status;
}
