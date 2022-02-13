<?php

namespace App\Service\StoreOwner;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Service\User\UserService;
use App\Entity\UserEntity;
use App\Request\User\UserRegisterRequest;
use App\Response\User\UserRegisterResponse;
use App\Manager\StoreOwner\StoreOwnerProfileManager;

class StoreOwnerProfileService
{
    private $autoMapping;
    private $userService;

    public function __construct(UserService $userService, AutoMapping $autoMapping, StoreOwnerProfileManager $storeOwnerProfileManager)
    {
        $this->autoMapping = $autoMapping;
        $this->userService = $userService;
        $this->storeOwnerProfileManager = $storeOwnerProfileManager;
    }

    public function storeOwnerRegister(UserRegisterRequest $request)
    {
        //TODO Use roomId (uuid) new feature of symfony .
        $userRegister = $this->storeOwnerProfileManager->storeOwnerRegister($request);

        if ($userRegister == "user is found") {
        $user['found']="yes";

        return $this->autoMapping->map("array", UserRegisterResponse::class, $user);
        }
      
        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);

    }
}
