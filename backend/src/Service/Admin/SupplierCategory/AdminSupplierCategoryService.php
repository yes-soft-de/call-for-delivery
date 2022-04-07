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

class AdminSupplierCategoryService
{
    private AutoMapping $autoMapping;
    private AdminSupplierCategoryManager $adminSupplierCategoryManager;

    public function __construct(AutoMapping $autoMapping, AdminSupplierCategoryManager $adminSupplierCategoryManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminSupplierCategoryManager = $adminSupplierCategoryManager;
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
}
