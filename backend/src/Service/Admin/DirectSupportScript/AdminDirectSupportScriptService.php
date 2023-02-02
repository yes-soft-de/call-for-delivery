<?php

namespace App\Service\Admin\DirectSupportScript;

use App\AutoMapping;
use App\Constant\Admin\AdminProfileConstant;
use App\Constant\DirectSupportScript\DirectSupportScriptResultConstant;
use App\Entity\AdminProfileEntity;
use App\Entity\DirectSupportScriptEntity;
use App\Manager\Admin\DirectSupportScript\AdminDirectSupportScriptManager;
use App\Request\Admin\DirectSupportScript\DirectSupportScriptCreateByAdminRequest;
use App\Request\Admin\DirectSupportScript\DirectSupportScriptDeleteByRequest;
use App\Request\Admin\DirectSupportScript\DirectSupportScriptFilterByAdminRequest;
use App\Request\Admin\DirectSupportScript\DirectSupportScriptUpdateByAdminRequest;
use App\Response\Admin\DirectSupportScript\DirectSupportScriptCreateByAdminResponse;
use App\Response\Admin\DirectSupportScript\DirectSupportScriptDeleteByAdminResponse;
use App\Response\Admin\DirectSupportScript\DirectSupportScriptFilterByAdminResponse;
use App\Response\Admin\DirectSupportScript\DirectSupportScriptUpdateByAdminResponse;
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

    public function updateDirectSupportScriptByAdmin(DirectSupportScriptUpdateByAdminRequest $request): string|int|DirectSupportScriptUpdateByAdminResponse
    {
        // First get admin profile
        $adminProfileEntity = $this->getAdminProfileEntityByAdminUserId($request->getAdminProfile());

        if ($adminProfileEntity === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;
        }

        // Now we can continue updating the required script
        $request->setAdminProfile($adminProfileEntity);

        $directSupportScript = $this->adminDirectSupportScriptManager->updateDirectSupportScriptByAdmin($request);

        if ($directSupportScript === DirectSupportScriptResultConstant::DIRECT_SUPPORT_SCRIPT_NOT_EXIST_CONST) {
            return DirectSupportScriptResultConstant::DIRECT_SUPPORT_SCRIPT_NOT_EXIST_CONST;
        }

        $response = $this->autoMapping->map(DirectSupportScriptEntity::class, DirectSupportScriptUpdateByAdminResponse::class,
            $directSupportScript);

        $response->adminName = $directSupportScript->getAdminProfile()->getName();

        return $response;
    }

    public function filterDirectSupportScriptByAdmin(DirectSupportScriptFilterByAdminRequest $request): array
    {
        $directSupportScripts = $this->adminDirectSupportScriptManager->filterDirectSupportScriptByAdmin($request);

        if (count($directSupportScripts) > 0) {
            $response = [];

            foreach ($directSupportScripts as $key => $value) {
                //dd($directSupportScript);
                $response[$key] = $this->autoMapping->map(DirectSupportScriptEntity::class, DirectSupportScriptFilterByAdminResponse::class,
                    $value);

                $response[$key]->adminName = $value->getAdminProfile()->getName();
            }

            return $response;
        }

        return $directSupportScripts;
    }

    public function deleteDirectSupportScriptByAdmin(DirectSupportScriptDeleteByRequest $request): int|DirectSupportScriptDeleteByAdminResponse
    {
        $directSupportScript = $this->adminDirectSupportScriptManager->deleteDirectSupportScriptByAdmin($request);

        if ($directSupportScript === DirectSupportScriptResultConstant::DIRECT_SUPPORT_SCRIPT_NOT_EXIST_CONST) {
            return DirectSupportScriptResultConstant::DIRECT_SUPPORT_SCRIPT_NOT_EXIST_CONST;
        }

        $response = $this->autoMapping->map(DirectSupportScriptEntity::class, DirectSupportScriptDeleteByAdminResponse::class,
            $directSupportScript);

        $response->adminName = $directSupportScript->getAdminProfile()->getName();

        return $response;
    }
}
