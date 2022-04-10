<?php

namespace App\Service\Admin\SupplierProfile;

use App\AutoMapping;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Entity\SupplierProfileEntity;
use App\Manager\Admin\SupplierProfile\AdminSupplierProfileManager;
use App\Request\Admin\SupplierProfile\SupplierProfileStatusUpdateByAdminRequest;
use App\Response\Admin\SupplierProfile\SupplierProfileGetByAdminResponse;
use App\Response\Admin\SupplierProfile\SupplierProfileStatusUpdateByAdminResponse;

class AdminSupplierProfileService
{
    private AutoMapping $autoMapping;
    private AdminSupplierProfileManager $adminSupplierProfileManager;

    public function __construct(AutoMapping $autoMapping, AdminSupplierProfileManager $adminSupplierProfileManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminSupplierProfileManager = $adminSupplierProfileManager;
    }

    public function updateSupplierProfileStatusByAdmin(SupplierProfileStatusUpdateByAdminRequest $request): string|SupplierProfileStatusUpdateByAdminResponse
    {
        $supplierProfileResult = $this->adminSupplierProfileManager->updateSupplierProfileStatusByAdmin($request);

        if ($supplierProfileResult === SupplierProfileConstant::SUPPLIER_PROFILE_NOT_EXIST) {
            return SupplierProfileConstant::SUPPLIER_PROFILE_NOT_EXIST;
        }

        return $this->autoMapping->map(SupplierProfileEntity::class, SupplierProfileStatusUpdateByAdminResponse::class, $supplierProfileResult);
    }
}
