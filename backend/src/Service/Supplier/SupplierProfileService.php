<?php

namespace App\Service\Supplier;

use App\AutoMapping;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\SupplierProfileEntity;
use App\Entity\UserEntity;
use App\Manager\Supplier\SupplierProfileManager;
use App\Request\Supplier\SupplierProfileUpdateRequest;
use App\Request\User\UserRegisterRequest;
use App\Response\Supplier\SupplierProfileGetResponse;
use App\Response\User\UserRegisterResponse;

class SupplierProfileService
{
    private AutoMapping $autoMapping;
    private SupplierProfileManager $supplierProfileManager;

    public function __construct(AutoMapping $autoMapping, SupplierProfileManager $supplierManager)
    {
        $this->autoMapping = $autoMapping;
        $this->supplierProfileManager = $supplierManager;
    }

    public function registerSupplier(UserRegisterRequest $request): UserRegisterResponse
    {
        $userRegister = $this->supplierProfileManager->registerSupplier($request);

        if($userRegister === UserReturnResultConstant::USER_IS_FOUND_RESULT) {
            $user = [];

            $user['found'] = UserReturnResultConstant::YES_RESULT;

            return $this->autoMapping->map("array", UserRegisterResponse::class, $user);
        }

        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }

    public function updateSupplierProfile(SupplierProfileUpdateRequest $request): string|SupplierProfileGetResponse
    {
        $supplierProfileResult = $this->supplierProfileManager->updateSupplierProfile($request);

        if ($supplierProfileResult === SupplierProfileConstant::SUPPLIER_PROFILE_NOT_EXIST) {
            return SupplierProfileConstant::SUPPLIER_PROFILE_NOT_EXIST;

        } else {
            return $this->autoMapping->map(SupplierProfileEntity::class, SupplierProfileGetResponse::class, $supplierProfileResult);
        }
    }
}
