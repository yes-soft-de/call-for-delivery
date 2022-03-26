<?php

namespace App\Manager\Admin;

use App\Constant\User\UserReturnResultConstant;
use App\Entity\UserEntity;
use App\Manager\Admin\AdminProfile\AdminProfileManager;
use App\Request\Admin\AdminRegisterRequest;
use App\Manager\User\UserManager;

class AdminManager
{
    private UserManager $userManager;
    private AdminProfileManager $adminProfileManager;

    public function __construct(UserManager $userManager, AdminProfileManager $adminProfileManager)
    {
        $this->userManager = $userManager;
        $this->adminProfileManager = $adminProfileManager;
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
                $this->adminProfileManager->createAdminProfileRegisteredAdmin($request, $userRegister->getId());

                return $userRegister;
            }
            else{
                return UserReturnResultConstant::USER_IS_NOT_CREATED_RESULT;
            }
        }
        else {
            $this->adminProfileManager->createAdminProfileRegisteredAdmin($request, $user['id']);

            return UserReturnResultConstant::USER_IS_FOUND_RESULT;
        }
    }
}
