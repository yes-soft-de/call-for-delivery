<?php

namespace App\Service\Admin;

use App\Request\Admin\AdminRegisterRequest;

interface AdminServiceInterface
{
    public function adminRegister(AdminRegisterRequest $request);
}
