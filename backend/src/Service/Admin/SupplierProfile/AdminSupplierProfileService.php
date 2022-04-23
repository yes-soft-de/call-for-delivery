<?php

namespace App\Service\Admin\SupplierProfile;

use App\AutoMapping;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Entity\SupplierProfileEntity;
use App\Entity\UserEntity;
use App\Manager\Admin\SupplierProfile\AdminSupplierProfileManager;
use App\Request\Admin\SupplierProfile\SupplierProfileFilterByAdminRequest;
use App\Request\Admin\SupplierProfile\SupplierProfileStatusUpdateByAdminRequest;
use App\Request\Admin\SupplierProfile\SupplierProfileUpdateByAdminRequest;
use App\Response\Admin\SupplierProfile\SupplierProfileGetByAdminResponse;
use App\Response\Admin\SupplierProfile\SupplierProfileStatusUpdateByAdminResponse;
use App\Service\FileUpload\UploadFileHelperService;

class AdminSupplierProfileService
{
    private AutoMapping $autoMapping;
    private AdminSupplierProfileManager $adminSupplierProfileManager;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, AdminSupplierProfileManager $adminSupplierProfileManager, UploadFileHelperService $uploadFileHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminSupplierProfileManager = $adminSupplierProfileManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
    }

    public function updateSupplierProfileStatusByAdmin(SupplierProfileStatusUpdateByAdminRequest $request): string|SupplierProfileStatusUpdateByAdminResponse
    {
        $supplierProfileResult = $this->adminSupplierProfileManager->updateSupplierProfileStatusByAdmin($request);

        if ($supplierProfileResult === SupplierProfileConstant::SUPPLIER_PROFILE_NOT_EXIST) {
            return SupplierProfileConstant::SUPPLIER_PROFILE_NOT_EXIST;
        }

        return $this->autoMapping->map(SupplierProfileEntity::class, SupplierProfileStatusUpdateByAdminResponse::class, $supplierProfileResult);
    }

    public function filterSupplierProfileByAdmin(SupplierProfileFilterByAdminRequest $request): array
    {
        $response = [];

        $suppliersProfiles = $this->adminSupplierProfileManager->filterSupplierProfileByAdmin($request);

        if (! empty($suppliersProfiles)) {
            foreach ($suppliersProfiles as $key => $value) {
                $response[] = $this->autoMapping->map(SupplierProfileEntity::class, SupplierProfileGetByAdminResponse::class, $value);

                $response[$key]->user = $this->getSpecificUserFields($value->getUser());

                $response[$key]->images = $this->customizeSupplierProfileImages($response[$key]->images->toArray());

                if ($value->getSupplierCategory()) {
                    $response[$key]->supplierCategoryName = $value->getSupplierCategory()->getName();
                }
            }
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

    public function getSpecificUserFields(UserEntity $userEntity): array
    {
        $response = [];

        $response['id'] = $userEntity->getId();
        $response['userId'] = $userEntity->getUserId();
        $response['roles'] = $userEntity->getRoles();

        return $response;
    }

    public function updateSupplierProfileByAdmin(SupplierProfileUpdateByAdminRequest $request): string|SupplierProfileStatusUpdateByAdminResponse
    {
        $supplierProfileResult = $this->adminSupplierProfileManager->updateSupplierProfileByAdmin($request);

        if ($supplierProfileResult === SupplierProfileConstant::SUPPLIER_PROFILE_NOT_EXIST) {
            return SupplierProfileConstant::SUPPLIER_PROFILE_NOT_EXIST;
        }

        return $this->autoMapping->map(SupplierProfileEntity::class, SupplierProfileStatusUpdateByAdminResponse::class, $supplierProfileResult);
    }

    public function getSupplierProfileBySupplierProfileIdForAdmin(int $supplierProfileId): SupplierProfileGetByAdminResponse|array
    {
        $response = [];

        $supplierProfile = $this->adminSupplierProfileManager->getSupplierProfileBySupplierProfileIdForAdmin($supplierProfileId);

        if ($supplierProfile) {
            $response = $this->autoMapping->map(SupplierProfileEntity::class, SupplierProfileGetByAdminResponse::class, $supplierProfile);

            $response->user = $this->getSpecificUserFields($supplierProfile->getUser());

            $response->images = $this->customizeSupplierProfileImages($response->images->toArray());

            if (! empty($supplierProfile->getSupplierCategories())) {
                $response->supplierCategories = $this->adminSupplierProfileManager->getSupplierCategoriesNamesBySupplierCategoriesIDs($supplierProfile->getSupplierCategories());
            }
        }

        return $response;
    }
}
