<?php

namespace App\Response\Admin\User;

use DateTime;
use OpenApi\Annotations as OA;

class UserGetForAdminResponse
{
    public int $id;

    public string $userId;

    /**
     * @OA\Property(type="array", property="roles",
     *     @OA\Items(type="string"))
     */
    public $roles;

    public DateTime $createDate;
}
