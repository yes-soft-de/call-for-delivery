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
use App\Service\FileUpload\UploadFileHelperService;

class SupplierProfileService
{
    private AutoMapping $autoMapping;
    private SupplierProfileManager $supplierProfileManager;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, SupplierProfileManager $supplierManager, UploadFileHelperService $uploadFileHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->supplierProfileManager = $supplierManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
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

    public function getSupplierProfileByUserId(int $userId)
    {
        $supplierProfile = $this->supplierProfileManager->getSupplierProfileByUserId($userId);

        if ($supplierProfile !== null) {
            $supplierProfile['image'] = $this->uploadFileHelperService->getImageParams($supplierProfile['image']);
        }

        return $this->autoMapping->map("array", SupplierProfileGetResponse::class, $supplierProfile);
    }
}
