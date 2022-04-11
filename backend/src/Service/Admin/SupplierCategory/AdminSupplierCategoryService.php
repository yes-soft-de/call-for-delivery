<?php

namespace App\Service\Admin\SupplierCategory;

use App\AutoMapping;
use App\Constant\SupplierCategory\SupplierCategoryResultConstant;
use App\Entity\SupplierCategoryEntity;
use App\Manager\Admin\SupplierCategory\AdminSupplierCategoryManager;
use App\Request\Admin\SupplierCategory\SupplierCategoryCreateByAdminRequest;
use App\Request\Admin\SupplierCategory\SupplierCategoryStatusUpdateByAdminRequest;
use App\Request\Admin\SupplierCategory\SupplierCategoryUpdateByAdminRequest;
use App\Response\Admin\SupplierCategory\SupplierCategoryCreateByAdminResponse;
use App\Response\Admin\SupplierCategory\SupplierCategoryGetByAdminResponse;
use App\Service\FileUpload\UploadFileHelperService;

class AdminSupplierCategoryService
{
    private AutoMapping $autoMapping;
    private AdminSupplierCategoryManager $adminSupplierCategoryManager;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, AdminSupplierCategoryManager $adminSupplierCategoryManager, UploadFileHelperService $uploadFileHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminSupplierCategoryManager = $adminSupplierCategoryManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
    }

    public function createSupplierCategoryByAdmin(SupplierCategoryCreateByAdminRequest $request): SupplierCategoryCreateByAdminResponse
    {
        $supplierCategoryResult = $this->adminSupplierCategoryManager->createSupplierCategoryByAdmin($request);

        return $this->autoMapping->map(SupplierCategoryEntity::class, SupplierCategoryCreateByAdminResponse::class, $supplierCategoryResult);
    }

    public function updateSupplierCategoryByAdmin(SupplierCategoryUpdateByAdminRequest $request): string|SupplierCategoryCreateByAdminResponse
    {
        $supplierCategoryResult = $this->adminSupplierCategoryManager->updateSupplierCategoryByAdmin($request);

        if ($supplierCategoryResult === SupplierCategoryResultConstant::SUPPLIER_CATEGORY_NOT_EXIST) {
            return SupplierCategoryResultConstant::SUPPLIER_CATEGORY_NOT_EXIST;
        }

        return $this->autoMapping->map(SupplierCategoryEntity::class, SupplierCategoryCreateByAdminResponse::class, $supplierCategoryResult);
    }

    public function updateSupplierCategoryStatusByAdmin(SupplierCategoryStatusUpdateByAdminRequest $request): string|SupplierCategoryCreateByAdminResponse
    {
        $supplierCategoryResult = $this->adminSupplierCategoryManager->updateSupplierCategoryStatusByAdmin($request);

        if ($supplierCategoryResult === SupplierCategoryResultConstant::SUPPLIER_CATEGORY_NOT_EXIST) {
            return SupplierCategoryResultConstant::SUPPLIER_CATEGORY_NOT_EXIST;
        }

        return $this->autoMapping->map(SupplierCategoryEntity::class, SupplierCategoryCreateByAdminResponse::class, $supplierCategoryResult);
    }

    public function getAllSupplierCategoriesForAdmin(): array
    {
        $response = [];

        $supplierCategories = $this->adminSupplierCategoryManager->getAllSupplierCategoriesForAdmin();

        if (! empty($supplierCategories)) {
            foreach ($supplierCategories as $supplierCategory) {
                $supplierCategory['image'] = $this->uploadFileHelperService->getImageParams($supplierCategory['image']);

                $response[] = $this->autoMapping->map("array", SupplierCategoryGetByAdminResponse::class, $supplierCategory);
            }
        }

        return $response;
    }
}
