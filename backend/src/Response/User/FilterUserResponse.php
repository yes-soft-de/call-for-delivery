<?php

namespace App\Response\User;

use OpenApi\Annotations as OA;

class FilterUserResponse
{
    public int $id;

    public string $userId;

    /**
     * @OA\Property(type="array", property="roles",
     *     @OA\Items(type="string"))
     */
    public $roles = [];

    public string $completeAccountStatus;
}
