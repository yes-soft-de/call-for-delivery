<?php

namespace App\Service\Admin\SupplierProfile;

use App\AutoMapping;
use App\Manager\Admin\SupplierProfile\AdminSupplierProfileManager;
use App\Request\Admin\SupplierProfile\SupplierProfileStatusUpdateByAdminRequest;

class AdminSupplierProfileService
{
    private AutoMapping $autoMapping;
    private AdminSupplierProfileManager $adminSupplierProfileManager;

    public function __construct(AutoMapping $autoMapping, AdminSupplierProfileManager $adminSupplierProfileManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminSupplierProfileManager = $adminSupplierProfileManager;
    }

    public function updateSupplierProfileStatusByAdmin(SupplierProfileStatusUpdateByAdminRequest $request)
    {
        $supplierProfile = $this->adminSupplierProfileManager->updateSupplierProfileStatusByAdmin($request);
    }
}
