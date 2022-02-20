<?php

namespace App\Manager\Admin;

use App\Constant\User\UserReturnResultConstant;
use App\Entity\UserEntity;
use App\Request\Admin\AdminRegisterRequest;
use App\Manager\User\UserManager;

class AdminManager
{
    private UserManager $userManager;

    public function __construct(UserManager $userManager)
    {
        $this->userManager = $userManager;
    }

    public function getUserByUserId($userID): ?array
    {
        return $this->userManager->getUserByUserId($userID);
    }

    public function adminRegister(AdminRegisterRequest $request): UserEntity|string
    {
        $user = $this->userManager->getUserByUserId($request->getUserId());

        if (! $user) {
            if(! $request->getRoles()) {
                $request->setRoles(["ROLE_ADMIN"]);
            }

            $userRegister = $this->userManager->createAdmin($request);

            if($userRegister){
                return $userRegister;
            }
            else{
                return UserReturnResultConstant::USER_IS_NOT_CREATED_RESULT;
            }
        }
        else {
            return UserReturnResultConstant::USER_IS_FOUND_RESULT;
        }
    }
}
