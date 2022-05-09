<?php

namespace App\Service\Supplier;

use App\AutoMapping;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\SupplierProfileEntity;
use App\Entity\UserEntity;
use App\Manager\Supplier\SupplierProfileManager;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Request\Supplier\SupplierProfileUpdateRequest;
use App\Request\User\UserRegisterRequest;
use App\Request\Verification\VerificationCreateRequest;
use App\Response\Supplier\SupplierProfileGetResponse;
use App\Response\Supplier\SupplierProfileUpdateResponse;
use App\Response\User\UserRegisterResponse;
use App\Service\FileUpload\UploadFileHelperService;
use App\Service\Verification\VerificationService;

class SupplierProfileService
{
    private AutoMapping $autoMapping;
    private SupplierProfileManager $supplierProfileManager;
    private UploadFileHelperService $uploadFileHelperService;
    private VerificationService $verificationService;

    public function __construct(AutoMapping $autoMapping, SupplierProfileManager $supplierManager, UploadFileHelperService $uploadFileHelperService, VerificationService $verificationService)
    {
        $this->autoMapping = $autoMapping;
        $this->supplierProfileManager = $supplierManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
        $this->verificationService = $verificationService;
    }

    public function registerSupplier(UserRegisterRequest $request): UserRegisterResponse
    {
        $userRegister = $this->supplierProfileManager->registerSupplier($request);

        if($userRegister === UserReturnResultConstant::USER_IS_FOUND_RESULT) {
            $user = [];

            $user['found'] = UserReturnResultConstant::YES_RESULT;

            return $this->autoMapping->map("array", UserRegisterResponse::class, $user);
        }

        // create verification code for the user
        //$this->createVerificationCodeForSupplier($userRegister);

        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }

    public function createVerificationCodeForSupplier(UserEntity $userEntity)
    {
        $verificationCodeRequest = new VerificationCreateRequest();

        $verificationCodeRequest->setUser($userEntity);

        $this->verificationService->createVerificationCode($verificationCodeRequest);
    }

    public function updateSupplierProfile(SupplierProfileUpdateRequest $request): string|SupplierProfileUpdateResponse
    {
        $supplierProfileResult = $this->supplierProfileManager->updateSupplierProfile($request);

        if ($supplierProfileResult === SupplierProfileConstant::SUPPLIER_PROFILE_NOT_EXIST) {
            return SupplierProfileConstant::SUPPLIER_PROFILE_NOT_EXIST;

        } else {
            return $this->autoMapping->map(SupplierProfileEntity::class, SupplierProfileUpdateResponse::class, $supplierProfileResult);
        }
    }

    public function getSupplierProfileByUserId(int $userId): array|SupplierProfileGetResponse
    {
        $response = [];

        $supplierProfile = $this->supplierProfileManager->getSupplierProfileByUserId($userId);

        if ($supplierProfile !== null) {
            if ($supplierProfile['roomId']) {
                $supplierProfile['roomId'] = $supplierProfile['roomId']->toBase32();
            }

            if (! empty($supplierProfile['supplierCategories'])) {
                $supplierProfile['supplierCategories'] = $this->supplierProfileManager->getSupplierCategoriesNamesBySupplierCategoriesIDs($supplierProfile['supplierCategories']);
            }

            $response = $this->autoMapping->map("array", SupplierProfileGetResponse::class, $supplierProfile);;

            $response->images = $this->customizeSupplierProfileImages($response->images);
        }

        return $response;
    }

    public function customizeSupplierProfileImages(array $imageEntitiesArray): ?array
    {
        $response = [];

        if (! empty($imageEntitiesArray)) {
            foreach ($imageEntitiesArray as $imageEntity) {
                $response[] = $this->uploadFileHelperService->getImageParams($imageEntity->getImagePath());
            }

            return $response;
        }

        return null;
    }

    public function getCompleteAccountStatusBySupplierId(int $supplierId): ?array
    {
        return $this->supplierProfileManager->getCompleteAccountStatusBySupplierId($supplierId);
    }

    public function supplierProfileCompleteAccountStatusUpdate(CompleteAccountStatusUpdateRequest $request): SupplierProfileEntity|string
    {
        return $this->supplierProfileManager->supplierProfileCompleteAccountStatusUpdate($request);
    }
}
