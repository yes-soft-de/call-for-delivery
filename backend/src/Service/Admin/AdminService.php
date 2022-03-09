<?php

namespace App\Service\Admin;

use App\AutoMapping;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\UserEntity;
use App\Manager\Admin\AdminManager;
use App\Request\Admin\AdminRegisterRequest;
use App\Response\User\UserRegisterResponse;
use App\Service\Admin\Order\AdminOrderService;
use App\Service\Admin\StoreOwner\AdminStoreOwnerService;

class AdminService implements AdminServiceInterface
{
    private AutoMapping $autoMapping;
    private AdminManager $adminManager;
    private AdminStoreOwnerService $adminStoreOwnerService;
    private AdminOrderService $adminOrderService;

    public function __construct(AutoMapping $autoMapping, AdminManager $adminManager, AdminStoreOwnerService $adminStoreOwnerService, AdminOrderService $adminOrderService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminManager = $adminManager;
        $this->adminStoreOwnerService = $adminStoreOwnerService;
        $this->adminOrderService = $adminOrderService;
    }

    public function adminRegister(AdminRegisterRequest $request): UserRegisterResponse
    {
        $userRegister = $this->adminManager->adminRegister($request);

        if($userRegister === UserReturnResultConstant::USER_IS_FOUND_RESULT) {
            $user['found'] = UserReturnResultConstant::YES_RESULT;

            return $this->autoMapping->map("array", UserRegisterResponse::class, $user);
        }

        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }
}
