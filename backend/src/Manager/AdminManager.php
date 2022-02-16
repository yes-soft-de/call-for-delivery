<?php

namespace App\Manager;

use App\Entity\UserEntity;
use App\Request\User\UserRegisterRequest;
use App\Manager\User\UserManager;

class AdminManager
{
    private $userManager;

    public function __construct(UserManager $userManager)
    {
        $this->userManager = $userManager;
    }

    public function getUserByUserId($userID): ?array
    {
        return $this->userManager->getUserByUserId($userID);
    }

    public function adminRegister(UserRegisterRequest $request): UserEntity|string
    {
        $user = $this->userManager->getUserByUserId($request->getUserId());

        if (!$user) {
            $request->setRoles(["ROLE_ADMIN"]);

            $userRegister = $this->userManager->createUser($request);
            if($userRegister){
                return $userRegister;
            }
            else{
                return 'not created user';
            }
        }
        else {
            return 'user is found';
        }
    }
}
