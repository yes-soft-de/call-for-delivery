<?php

namespace App\Service\User;

use App\Manager\User\UserManager;

class UserService
{
    private UserManager $userManager;

    public function __construct(UserManager $userManager)
    {
        $this->userManager = $userManager;
    }

    public function getUserRoleByUserId($userID): ?array
    {
        return $this->userManager->getUserRoleByUserId($userID);
    }

    public function checkUserType($userType,$userID): string
    {
        return $this->userManager->checkUserType($userType,$userID);
    }
}
