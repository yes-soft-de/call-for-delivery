<?php

namespace App\Service\Main;

use App\Constant\Main\BackendHealthStatusConstant;
use App\Request\User\UserPasswordUpdateBySuperAdminRequest;
use App\Response\User\UserRegisterResponse;
use App\Service\User\UserService;

class MainService
{
    private UserService $userService;

    public function __construct(UserService $userService)
    {
        $this->userService = $userService;
    }

    public function checkBackendHealth($userId): ?array
    {
        $response = [];

        $userRole = $this->userService->getUserRoleByUserId($userId);

        if ($userRole) {
            $response['userRole'] = $userRole['roles'];
        }

        $response['result'] = BackendHealthStatusConstant::HEART_IS_BEATING_STATUS;

        return $response;
    }

    public function filterUsersBySuperAdmin($request): array
    {
        return $this->userService->filterUsersBySuperAdmin($request);
    }

    public function updateUserPasswordBySuperAdmin(UserPasswordUpdateBySuperAdminRequest $request): string|UserRegisterResponse
    {
        return $this->userService->updateUserPasswordBySuperAdmin($request);
    }
}
