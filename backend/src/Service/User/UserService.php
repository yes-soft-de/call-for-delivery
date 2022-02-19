<?php

namespace App\Service\User;

use App\AutoMapping;
use App\Manager\User\UserManager;
use App\Response\User\FilterUserResponse;

class UserService
{
    private UserManager $userManager;
    private AutoMapping $autoMapping;

    public function __construct(UserManager $userManager, AutoMapping $autoMapping)
    {
        $this->userManager = $userManager;
        $this->autoMapping = $autoMapping;
    }

    public function getUserRoleByUserId($userID): ?array
    {
        return $this->userManager->getUserRoleByUserId($userID);
    }

    public function checkUserType($userType,$userID): string
    {
        return $this->userManager->checkUserType($userType,$userID);
    }

    public function filterUsers($request): array
    {
        $response = [];

        $users = $this->userManager->filterUsers($request);

        foreach ($users as $user)
        {
            $response[] = $this->autoMapping->map('array', FilterUserResponse::class, $user);
        }

        return $response;
    }
}
