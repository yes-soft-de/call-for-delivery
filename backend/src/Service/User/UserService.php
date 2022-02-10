<?php

namespace App\Service\User;

use App\Manager\User\UserManager;

class UserService
{
    private $userManager;

    public function __construct(UserManager $userManager)
    {
        $this->userManager = $userManager;
    }

    public function getUserRoleByUserId($userID): ?array
    {
        return $this->userManager->getUserRoleByUserId($userID);
    }
}
