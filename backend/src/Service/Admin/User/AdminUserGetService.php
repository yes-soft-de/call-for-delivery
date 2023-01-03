<?php

namespace App\Service\Admin\User;

use App\Manager\Admin\User\AdminUserManager;

class AdminUserGetService
{
    private AdminUserManager $adminUserManager;

    public function __construct(AdminUserManager $adminUserManager)
    {
        $this->adminUserManager = $adminUserManager;
    }

    public function getUsersIDsByRoleForAdmin(string $userRole): array
    {
        return $this->adminUserManager->getUsersIDsByRoleForAdmin($userRole);
    }
}
