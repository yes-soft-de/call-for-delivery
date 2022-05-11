<?php

namespace App\Response\Admin\ResetPassword;

use DateTime;
use OpenApi\Annotations as OA;

class ResetPasswordOrderGetForSuperAdminResponse
{
    public int $id;

    /**
     * @OA\Property(type="object", property="user")
     */
    public $user;

    public string $code;

    public bool $codeStatus;

    public DateTime $createdAt;

    public DateTime $updatedAt;
}
