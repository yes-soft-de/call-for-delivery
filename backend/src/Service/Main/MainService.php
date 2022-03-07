<?php

namespace App\Service\Main;

use App\AutoMapping;
use App\Constant\Main\BackendHealthStatusConstant;
use App\Constant\User\UserRoleConstant;
use App\Request\User\UserPasswordUpdateBySuperAdminRequest;
use App\Response\Main\CompleteAccountStatusGetResponse;
use App\Response\User\UserRegisterResponse;
use App\Service\StoreOwner\StoreOwnerProfileService;
use App\Service\User\UserService;

class MainService
{
    private UserService $userService;
    private AutoMapping $autoMapping;
    private StoreOwnerProfileService $storeOwnerProfileService;

    public function __construct(UserService $userService, AutoMapping $autoMapping, StoreOwnerProfileService $storeOwnerProfileService)
    {
        $this->userService = $userService;
        $this->autoMapping = $autoMapping;
        $this->storeOwnerProfileService = $storeOwnerProfileService;
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

    public function getCompleteAccountStatusByUserId(string $userId, string $userType): ?CompleteAccountStatusGetResponse
    {
        if($userType === UserRoleConstant::STORE_OWNER_USER_TYPE) {
            $completeAccountStatus = $this->storeOwnerProfileService->getCompleteAccountStatusByStoreOwnerId($userId);

            return $this->autoMapping->map('array', CompleteAccountStatusGetResponse::class, $completeAccountStatus);
        }

        // sections for captain and supplier will be added lately when both entities will be set
    }
}
