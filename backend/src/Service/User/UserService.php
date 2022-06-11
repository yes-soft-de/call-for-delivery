<?php

namespace App\Service\User;

use App\AutoMapping;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\UserEntity;
use App\Manager\User\UserManager;
use App\Request\User\UserPasswordUpdateBySuperAdminRequest;
use App\Request\User\UserPasswordUpdateRequest;
use App\Request\User\UserVerificationStatusUpdateRequest;
use App\Response\User\FilterUserResponse;
use App\Response\User\UserRegisterResponse;
use App\Response\User\UserVerificationStatusUpdateResponse;

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

    public function checkUserType(string $userType, int $userId): string
    {
        return $this->userManager->checkUserType($userType, $userId);
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

    public function getUserBySupplierProfileId(int $supplierProfileId): ?UserEntity
    {
        return $this->userManager->getUserBySupplierProfileId($supplierProfileId);
    }

    public function updateUserVerificationStatus(UserVerificationStatusUpdateRequest $request): string|UserVerificationStatusUpdateResponse
    {
        $userResult = $this->userManager->updateUserVerificationStatus($request);

        if ($userResult === UserReturnResultConstant::USER_NOT_FOUND_RESULT) {
            return $userResult;
        }

        return $this->autoMapping->map(UserEntity::class, UserVerificationStatusUpdateResponse::class, $userResult);
    }

    public function getUserVerificationStatusByUserId(string $userId): ?array
    {
        return $this->userManager->getUserVerificationStatusByUserId($userId);
    }

    public function getUseEntityByUserId(string $userId): ?UserEntity
    {
        return $this->userManager->getUserEntityByUserId($userId);
    }

    // this function update verificationStatus field of all users to be 'true'
    public function verifyAllUsers(): array
    {
        $response = [];

        $usersResult = $this->userManager->verifyAllUsers();

        foreach ($usersResult as $user) {
            $response[] = $this->autoMapping->map(UserEntity::class, FilterUserResponse::class, $user);
        }

        return $response;
    }

    public function getUserByUserIdAndRole(string $userId, string $role): ?UserEntity
    {
        return $this->userManager->getUserByUserIdAndRole($userId, $role);
    }

    public function updateUserPassword(UserPasswordUpdateRequest $request): string|UserRegisterResponse
    {
        $result = $this->userManager->updateUserPassword($request);

        if ($result === UserReturnResultConstant::USER_NOT_FOUND_RESULT) {
            return $result;
        }

        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $result);
    }

    public function getSupplierUsersEntitiesBySupplierCategoryId(int $supplierCategoryId): array
    {
        return $this->userManager->getSupplierUsersEntitiesBySupplierCategoryId($supplierCategoryId);
    }

    public function deleteUserById(int $id): ?UserEntity
    {
        return $this->userManager->deleteUserById($id);
    }
}
