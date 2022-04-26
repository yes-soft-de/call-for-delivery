<?php

namespace App\Service\Admin\User;

use App\AutoMapping;
use App\Constant\Admin\User\AdminUserConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\UserEntity;
use App\Manager\Admin\User\AdminUserManager;
use App\Request\Admin\User\UserIdUpdateRequest;
use App\Response\Admin\User\UserGetForAdminResponse;

class AdminUserService
{
    private AutoMapping $autoMapping;
    private AdminUserManager $adminUserManager;

    public function __construct(AutoMapping $autoMapping, AdminUserManager $adminUserManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminUserManager = $adminUserManager;
    }

    public function updateUserIdBySuperAdmin(UserIdUpdateRequest $request): string|UserGetForAdminResponse
    {
        $userResult = $this->adminUserManager->updateUserIdBySuperAdmin($request);

        if ($userResult === AdminUserConstant::WRONG_PASSWORD || $userResult === UserReturnResultConstant::USER_IS_NOT_CREATED_RESULT) {
            return $userResult;
        }

        return $this->autoMapping->map(UserEntity::class, UserGetForAdminResponse::class, $userResult);
    }
}
