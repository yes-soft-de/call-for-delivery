<?php

namespace App\Service\User;

use App\AutoMapping;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\UserEntity;
use App\Manager\User\UserManager;
use App\Request\User\UserPasswordUpdateBySuperAdminRequest;
use App\Response\User\FilterUserResponse;
use App\Response\User\UserRegisterResponse;

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

    public function filterUsersBySuperAdmin($request): array
    {
        $response = [];

        $users = $this->userManager->filterUsersBySuperAdmin($request);

        foreach ($users as $user)
        {
            $response[] = $this->autoMapping->map('array', FilterUserResponse::class, $user);
        }

        return $response;
    }

    public function updateUserPasswordBySuperAdmin(UserPasswordUpdateBySuperAdminRequest $request): string|UserRegisterResponse
    {
        $userResult = $this->userManager->updateUserPasswordBySuperAdmin($request);

        if($userResult === UserReturnResultConstant::USER_NOT_FOUND_RESULT) {
            return $userResult;
        }

        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userResult);
    }
    
    public function getUserByCaptainProfileId($captainProfileId): ?UserEntity
    {
        return $this->userManager->getUserByCaptainProfileId($captainProfileId);
    }

    public function getUserByStoreProfileId($storeProfileId): ?UserEntity
    {
        return $this->userManager->getUserByStoreProfileId($storeProfileId);
    }
}
