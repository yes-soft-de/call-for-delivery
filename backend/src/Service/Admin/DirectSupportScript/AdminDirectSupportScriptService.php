<?php

namespace App\Service\Admin\DirectSupportScript;

use App\AutoMapping;
use App\Constant\Admin\AdminProfileConstant;
use App\Entity\AdminProfileEntity;
use App\Entity\DirectSupportScriptEntity;
use App\Manager\Admin\DirectSupportScript\AdminDirectSupportScriptManager;
use App\Request\Admin\DirectSupportScript\DirectSupportScriptCreateByAdminRequest;
use App\Response\Admin\DirectSupportScript\DirectSupportScriptCreateByAdminResponse;
use App\Service\Admin\AdminProfile\AdminProfileGetService;

class AdminDirectSupportScriptService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminDirectSupportScriptManager $adminDirectSupportScriptManager,
        private AdminProfileGetService $adminProfileGetService
    )
    {
    }

    public function getAdminProfileEntityByAdminUserId(int $adminUserId): AdminProfileEntity|string
    {
        $adminProfileEntity = $this->adminProfileGetService->getAdminProfileEntityByAdminUserId($adminUserId);

        if ($adminProfileEntity === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;
        }

        return $adminProfileEntity;
    }

    public function createDirectSupportScriptByAdmin(DirectSupportScriptCreateByAdminRequest $request): string|DirectSupportScriptCreateByAdminResponse
    {
        // First get admin profile
        $adminProfileEntity = $this->getAdminProfileEntityByAdminUserId($request->getAdminProfile());

        if ($adminProfileEntity === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;
        }

        // Now we can continue creating the required script
        $request->setAdminProfile($adminProfileEntity);

        $directSupportScript = $this->adminDirectSupportScriptManager->createDirectSupportScriptByAdmin($request);

        $response = $this->autoMapping->map(DirectSupportScriptEntity::class, DirectSupportScriptCreateByAdminResponse::class,
            $directSupportScript);

        $response->adminName = $directSupportScript->getAdminProfile()->getName();

        return $response;
    }
}
