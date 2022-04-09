<?php

namespace App\Manager\Admin\SupplierProfile;

use App\AutoMapping;
use App\Request\Admin\SupplierProfile\SupplierProfileStatusUpdateByAdminRequest;

class AdminSupplierProfileManager
{
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping)
    {
        $this->autoMapping = $autoMapping;
    }

    public function updateSupplierProfileStatusByAdmin(SupplierProfileStatusUpdateByAdminRequest $request)
    {

    }
}
