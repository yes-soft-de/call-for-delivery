<?php

namespace App\Response\ResetPassword;

use DateTime;

class ResetPasswordOrderGetResponse
{
    /**
     * @var DateTime|null
     */
    public $createdAt;

    /**
     * used when no user is found
     * @var string|null
     */
    public $status;
}
