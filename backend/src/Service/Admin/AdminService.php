<?php

namespace App\Service\Admin;

use App\AutoMapping;
use App\Entity\User\UserEntity;
use App\Manager\Admin\AdminManager;
use App\Request\User\UserRegisterRequest;
use App\Response\User\UserRegisterResponse;

class AdminService
{
    private $autoMapping;
    private $adminManager;

    public function __construct(AutoMapping $autoMapping, AdminManager $adminManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminManager = $adminManager;
    }

    public function adminRegister(UserRegisterRequest $request)
    {
        $userRegister = $this->adminManager->adminRegister($request);

        if ($userRegister == "user is found")
        {
            $user['found'] = "yes";

            return $this->autoMapping->map("array", UserRegisterResponse::class, $user);
        }

        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }
}
